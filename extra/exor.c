#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv)
{
    if( argc != 3 )
    {
        fprintf(stderr, "Usage: %s <input_file> <output_file>\n", argv[0]);
        return 1;
    }
    FILE *fi = fopen(argv[1], "rb");
    if( !fi )
    {
        fprintf(stderr, "%s: can´t open input '%s': %s\n", argv[0], argv[1], strerror(errno));
        return 1;
    }
    if( getc(fi) != 0xFF || getc(fi) != 0xFF )
    {
        fclose(fi);
        fprintf(stderr, "%s: not Atari XEX file.\n", argv[1]);
        return 1;
    }
    int astart = getc(fi) | (getc(fi) << 8);
    int aend   = getc(fi) | (getc(fi) << 8);
    if( astart != 0xA800 )
    {
        fclose(fi);
        fprintf(stderr, "%s: unexpected start address $%04x.\n", argv[1], astart);
        return 1;
    }
    if( aend < 0xA820 || aend >= 0xB800 )
    {
        fclose(fi);
        fprintf(stderr, "%s: unexpected end address $%04x.\n", argv[1], aend);
        return 1;
    }
    if( getc(fi) != 0x4c )
    {
        fclose(fi);
        fprintf(stderr, "%s: does not start with JMP.\n", argv[1]);
        return 1;
    }
    int pend   = getc(fi) | (getc(fi) << 8);
    if( pend < 0xA820 || pend >= aend - 0x10 )
    {
        fclose(fi);
        fprintf(stderr, "%s: unexpected proc address $%04x.\n", argv[1], pend);
        return 1;
    }
    // Ok, read from current position up to pend:
    int len = pend - astart - 3;
    unsigned char *buf = malloc(len);
    if( !buf )
        return 1;
    if( 1 != fread(buf, len, 1, fi) )
    {
        free(buf);
        fclose(fi);
        fprintf(stderr, "%s: unexpected end of XEX.\n", argv[1]);
        return 1;
    }
    int lda = getc(fi);
    if( lda != 0xA9 )
    {
        free(buf);
        fclose(fi);
        fprintf(stderr, "%s: does not end with LDA ABS: %02x.\n", argv[1], lda);
        return 1;
    }
    int cstart = getc(fi) | (astart & 0xFF00);
    if( cstart < astart + 3 || cstart >= pend )
    {
        fclose(fi);
        fprintf(stderr, "%s: unexpected code start address $%04x.\n", argv[1], cstart);
        return 1;
    }
    // End read
    fclose(fi);

    // Extract start address from code:
    int radd = buf[1] | (buf[2]<<8);
    if( radd == 0xE474 )
        radd = 0x6000;
    else
        radd = radd & 0xFF00;

    fprintf(stderr, "%s: Detected start address: $%04x\n", argv[1], radd);

    // Now, "encrypt":
    for(int i=cstart - astart - 3; i < len; i++)
        buf[i] ^= 0x55;

    // And save
    FILE *fo = fopen(argv[2], "wb");
    if( !fo )
    {
        free(buf);
        fprintf(stderr, "%s: can´t open output '%s': %s\n", argv[0], argv[2], strerror(errno));
        return 1;
    }
    putc(0xFF, fo);
    putc(0xFF, fo);
    putc(radd & 0xFF, fo);
    putc(radd >> 8, fo);
    putc((len + radd - 1) & 0xFF, fo);
    putc((len + radd - 1) >> 8, fo);
    fwrite(buf, len, 1, fo);
    fclose(fo);

    return 0;
}
