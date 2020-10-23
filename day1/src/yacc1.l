%%
[0-9]+ { return NUMBER; }
"+" { return PLUS; }
[\t\n ] { /* nothing to do */ }
. { printf("bad input character!!\n");
printf("ignored!\n"); }
