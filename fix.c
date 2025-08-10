static void fibonacci(Monitor *m, int s) {
    unsigned int i, n;
    int nx, ny, nw, nh;
    Client *c;

    n = 0;
    for (c = nexttiled(m->clients); c; c = nexttiled(c->next))
        n++;
    if (n == 0)
        return;

    nx = m->wx;
    ny = m->wy;
    nw = m->ww;
    nh = m->wh;

    for (i = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next)) {
        if ((i % 2 && nh / 2 <= (bh + 2 * c->bw))
         || (!(i % 2) && nw / 2 <= (bh + 2 * c->bw)))
            break;

        if (i < n - 1) {
            if (i % 2)
                nh /= 2;
            else
                nw /= 2;

            if ((i % 4) == 2 && !s)
                nx += nw;
            else if ((i % 4) == 3 && !s)
                ny += nh;
        }

        resize(c, nx, ny, nw - 2 * c->bw, nh - 2 * c->bw, 0);
        if (i % 2)
            nx += nw;
        else
            ny += nh;
        i++;
    }
}

static void dwindle(Monitor *m) { fibonacci(m, 1); }
static void spiral(Monitor *m)  { fibonacci(m, 0); }
