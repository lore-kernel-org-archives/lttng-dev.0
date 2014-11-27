From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: [lttng-tools] Fix: channel name with '.' and '/'
 brings problems
Date: Wed, 26 Nov 2014 22:46:26 -0500
Message-ID: <CAF4oYfGk8mWnBU3OdTNFXJxXfHFB-G1mOWciLGb-27qvskEKPA__18811.5604840734$1417060040$gmane$org@mail.gmail.com>
References: <1417059132-14298-1-git-send-email-eeppeliteloop@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0603764301=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yh0-f50.google.com ([209.85.213.50])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.r.julien@gmail.com>) id 1Xtq2J-0005GO-PA
 for lttng-dev@lists.lttng.org; Wed, 26 Nov 2014 22:46:34 -0500
Received: by mail-yh0-f50.google.com with SMTP id 29so2072537yhl.23
 for <lttng-dev@lists.lttng.org>; Wed, 26 Nov 2014 19:46:26 -0800 (PST)
In-Reply-To: <1417059132-14298-1-git-send-email-eeppeliteloop@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0603764301==
Content-Type: multipart/alternative; boundary=089e01229e861af1bb0508cefd73

--089e01229e861af1bb0508cefd73
Content-Type: text/plain; charset=UTF-8

Hey Phil,

Not sure if modifying user input without any warnings about it is a good
idea. This clearly solve problems but do we want to solve it this way ?

It might be a better idea to warn the user about improper channel name or
simply block the command and return an error.

On Wed, Nov 26, 2014 at 10:32 PM, Philippe Proulx <eeppeliteloop@gmail.com>
wrote:

> This patch ensures:
>
>   1. A channel name does not contain any '/' character, since
>      relative paths may be injected in the channel name
>      otherwise (knowing that the channel name is eventually
>      part of a file name)
>   2. A channel name does not start with a '.' character, since
>      trace readers (Babeltrace is one of them) could interpret
>      files starting with a dot as hidden files and ignore
>      them when opening the CTF trace
>
> Fixes: #751
>
> Signed-off-by: Philippe Proulx <eeppeliteloop@gmail.com>
> ---
>  src/bin/lttng/commands/enable_channels.c | 38
> +++++++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/src/bin/lttng/commands/enable_channels.c
> b/src/bin/lttng/commands/enable_channels.c
> index f8272e9..e6cce49 100644
> --- a/src/bin/lttng/commands/enable_channels.c
> +++ b/src/bin/lttng/commands/enable_channels.c
> @@ -275,11 +275,39 @@ static int enable_channel(char *session_name)
>         /* Strip channel list (format: chan1,chan2,...) */
>         channel_name = strtok(opt_channels, ",");
>         while (channel_name != NULL) {
> -               /* Copy channel name and normalize it */
> +               /* Copy channel name, sanitize and normalize it */
>                 strncpy(chan.name, channel_name, NAME_MAX);
>                 chan.name[NAME_MAX - 1] = '\0';
>
> -               DBG("Enabling channel %s", channel_name);
> +               char *src, *dst;
> +               int got_first = 0;
> +
> +               for (src = dst = chan.name; *src != '\0'; ++src) {
> +                       *dst = *src;
> +
> +                       /*
> +                        * Channel name could be used in file names, so
> remove
> +                        * invalid '/'
> +                        */
> +                       if (*dst != '/') {
>

Maybe send some warning here ?


> +                               /*
> +                                * Remove starting dots since this could
> create
> +                                * file names starting with dots, and trace
> +                                * readers could interpret them as hidden
> files
> +                                * and ignore them.
> +                                */
> +                               if (*dst != '.') {
>

Same


> +                                       got_first = 1;
> +                                       dst++;
> +                               } else if (got_first) {
> +                                       dst++;
> +                               }
> +                       }
> +               }
> +
> +               *dst = '\0';
> +
> +               DBG("Enabling channel %s", chan.name);
>
>                 ret = lttng_enable_channel(handle, &chan);
>                 if (ret < 0) {
> @@ -288,19 +316,19 @@ static int enable_channel(char *session_name)
>                         case LTTNG_ERR_KERN_CHAN_EXIST:
>                         case LTTNG_ERR_UST_CHAN_EXIST:
>                         case LTTNG_ERR_CHAN_EXIST:
> -                               WARN("Channel %s: %s (session %s)",
> channel_name,
> +                               WARN("Channel %s: %s (session %s)",
> chan.name,
>                                                 lttng_strerror(ret),
> session_name);
>                                 warn = 1;
>                                 break;
>                         default:
> -                               ERR("Channel %s: %s (session %s)",
> channel_name,
> +                               ERR("Channel %s: %s (session %s)",
> chan.name,
>                                                 lttng_strerror(ret),
> session_name);
>                                 error = 1;
>                                 break;
>                         }
>                 } else {
>                         MSG("%s channel %s enabled for session %s",
> -                                       get_domain_str(dom.type),
> channel_name, session_name);
> +                                       get_domain_str(dom.type),
> chan.name, session_name);
>                         success = 1;
>                 }
>
> --
> 2.1.3
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- 
Jonathan Rajotte Julien

--089e01229e861af1bb0508cefd73
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGV5IFBoaWwsPGRpdj48YnI+PC9kaXY+PGRpdj5Ob3Qgc3VyZSBpZiBt
b2RpZnlpbmcgdXNlciBpbnB1dCB3aXRob3V0IGFueSB3YXJuaW5ncyBhYm91dCBpdCBpcyBhIGdv
b2QgaWRlYS4gVGhpcyBjbGVhcmx5IHNvbHZlIHByb2JsZW1zIGJ1dCBkbyB3ZSB3YW50IHRvIHNv
bHZlIGl0IHRoaXMgd2F5ID/CoDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SXQgbWlnaHQgYmUg
YSBiZXR0ZXIgaWRlYSB0byB3YXJuIHRoZSB1c2VyIGFib3V0IGltcHJvcGVyIGNoYW5uZWwgbmFt
ZSBvciBzaW1wbHkgYmxvY2sgdGhlIGNvbW1hbmQgYW5kIHJldHVybiBhbiBlcnJvci48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2Pk9uIFdlZCwgTm92IDI2LCAyMDE0IGF0IDEwOjMyIFBNLCBQaGls
aXBwZSBQcm91bHggPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86ZWVwcGVsaXRl
bG9vcEBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5lZXBwZWxpdGVsb29wQGdtYWlsLmNvbTwv
YT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PC9kaXY+PGRpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRy
YSI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90
ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3Bh
ZGRpbmctbGVmdDoxZXgiPlRoaXMgcGF0Y2ggZW5zdXJlczo8YnI+DQo8YnI+DQrCoCAxLiBBIGNo
YW5uZWwgbmFtZSBkb2VzIG5vdCBjb250YWluIGFueSAmIzM5Oy8mIzM5OyBjaGFyYWN0ZXIsIHNp
bmNlPGJyPg0KwqAgwqAgwqByZWxhdGl2ZSBwYXRocyBtYXkgYmUgaW5qZWN0ZWQgaW4gdGhlIGNo
YW5uZWwgbmFtZTxicj4NCsKgIMKgIMKgb3RoZXJ3aXNlIChrbm93aW5nIHRoYXQgdGhlIGNoYW5u
ZWwgbmFtZSBpcyBldmVudHVhbGx5PGJyPg0KwqAgwqAgwqBwYXJ0IG9mIGEgZmlsZSBuYW1lKTxi
cj4NCsKgIDIuIEEgY2hhbm5lbCBuYW1lIGRvZXMgbm90IHN0YXJ0IHdpdGggYSAmIzM5Oy4mIzM5
OyBjaGFyYWN0ZXIsIHNpbmNlPGJyPg0KwqAgwqAgwqB0cmFjZSByZWFkZXJzIChCYWJlbHRyYWNl
IGlzIG9uZSBvZiB0aGVtKSBjb3VsZCBpbnRlcnByZXQ8YnI+DQrCoCDCoCDCoGZpbGVzIHN0YXJ0
aW5nIHdpdGggYSBkb3QgYXMgaGlkZGVuIGZpbGVzIGFuZCBpZ25vcmU8YnI+DQrCoCDCoCDCoHRo
ZW0gd2hlbiBvcGVuaW5nIHRoZSBDVEYgdHJhY2U8YnI+DQo8YnI+DQpGaXhlczogIzc1MTxicj4N
Cjxicj4NClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIFByb3VseCAmbHQ7PGEgaHJlZj0ibWFpbHRv
OmVlcHBlbGl0ZWxvb3BAZ21haWwuY29tIj5lZXBwZWxpdGVsb29wQGdtYWlsLmNvbTwvYT4mZ3Q7
PGJyPg0KLS0tPGJyPg0KwqBzcmMvYmluL2x0dG5nL2NvbW1hbmRzL2VuYWJsZV9jaGFubmVscy5j
IHwgMzggKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS08YnI+DQrCoDEgZmlsZSBjaGFu
Z2VkLCAzMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKTxicj4NCjxicj4NCmRpZmYgLS1n
aXQgYS9zcmMvYmluL2x0dG5nL2NvbW1hbmRzL2VuYWJsZV9jaGFubmVscy5jIGIvc3JjL2Jpbi9s
dHRuZy9jb21tYW5kcy9lbmFibGVfY2hhbm5lbHMuYzxicj4NCmluZGV4IGY4MjcyZTkuLmU2Y2Nl
NDkgMTAwNjQ0PGJyPg0KLS0tIGEvc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9lbmFibGVfY2hhbm5l
bHMuYzxicj4NCisrKyBiL3NyYy9iaW4vbHR0bmcvY29tbWFuZHMvZW5hYmxlX2NoYW5uZWxzLmM8
YnI+DQpAQCAtMjc1LDExICsyNzUsMzkgQEAgc3RhdGljIGludCBlbmFibGVfY2hhbm5lbChjaGFy
ICpzZXNzaW9uX25hbWUpPGJyPg0KwqAgwqAgwqAgwqAgLyogU3RyaXAgY2hhbm5lbCBsaXN0IChm
b3JtYXQ6IGNoYW4xLGNoYW4yLC4uLikgKi88YnI+DQrCoCDCoCDCoCDCoCBjaGFubmVsX25hbWUg
PSBzdHJ0b2sob3B0X2NoYW5uZWxzLCAmcXVvdDssJnF1b3Q7KTs8YnI+DQrCoCDCoCDCoCDCoCB3
aGlsZSAoY2hhbm5lbF9uYW1lICE9IE5VTEwpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAvKiBDb3B5IGNoYW5uZWwgbmFtZSBhbmQgbm9ybWFsaXplIGl0ICovPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgLyogQ29weSBjaGFubmVsIG5hbWUsIHNhbml0aXplIGFuZCBub3JtYWxp
emUgaXQgKi88YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzdHJuY3B5KDxhIGhyZWY9Imh0
dHA6Ly9jaGFuLm5hbWUiIHRhcmdldD0iX2JsYW5rIj5jaGFuLm5hbWU8L2E+LCBjaGFubmVsX25h
bWUsIE5BTUVfTUFYKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YSBocmVmPSJodHRw
Oi8vY2hhbi5uYW1lIiB0YXJnZXQ9Il9ibGFuayI+Y2hhbi5uYW1lPC9hPltOQU1FX01BWCAtIDFd
ID0gJiMzOTtcMCYjMzk7Ozxicj4NCjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoERCRygm
cXVvdDtFbmFibGluZyBjaGFubmVsICVzJnF1b3Q7LCBjaGFubmVsX25hbWUpOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGNoYXIgKnNyYywgKmRzdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpbnQgZ290X2ZpcnN0ID0gMDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZm9yIChzcmMgPSBkc3QgPSA8YSBocmVmPSJodHRwOi8vY2hhbi5uYW1lIiB0YXJnZXQ9
Il9ibGFuayI+Y2hhbi5uYW1lPC9hPjsgKnNyYyAhPSAmIzM5O1wwJiMzOTs7ICsrc3JjKSB7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKmRzdCA9ICpzcmM7PGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogQ2hhbm5lbCBuYW1lIGNvdWxkIGJlIHVz
ZWQgaW4gZmlsZSBuYW1lcywgc28gcmVtb3ZlPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICogaW52YWxpZCAmIzM5Oy8mIzM5Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAqLzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGlmICgqZHN0ICE9ICYjMzk7LyYjMzk7KSB7PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxi
cj48L2Rpdj48ZGl2Pk1heWJlIHNlbmQgc29tZSB3YXJuaW5nIGhlcmUgPzwvZGl2PjxkaXY+wqA8
L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAg
LjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogUmVtb3ZlIHN0YXJ0
aW5nIGRvdHMgc2luY2UgdGhpcyBjb3VsZCBjcmVhdGU8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBmaWxlIG5hbWVzIHN0YXJ0aW5nIHdpdGgg
ZG90cywgYW5kIHRyYWNlPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICogcmVhZGVycyBjb3VsZCBpbnRlcnByZXQgdGhlbSBhcyBoaWRkZW4gZmls
ZXM8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
KiBhbmQgaWdub3JlIHRoZW0uPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgICovPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgKCpkc3QgIT0gJiMzOTsuJiMzOTspIHs8YnI+PC9ibG9ja3F1b3Rl
PjxkaXY+PGJyPjwvZGl2PjxkaXY+U2FtZTwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDox
cHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdF9maXJzdCA9IDE7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZHN0Kys7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgfSBlbHNlIGlmIChnb3RfZmlyc3QpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkc3QrKzs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKmRzdCA9ICYjMzk7XDAmIzM5
Ozs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgREJHKCZxdW90O0VuYWJsaW5n
IGNoYW5uZWwgJXMmcXVvdDssIDxhIGhyZWY9Imh0dHA6Ly9jaGFuLm5hbWUiIHRhcmdldD0iX2Js
YW5rIj5jaGFuLm5hbWU8L2E+KTs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBy
ZXQgPSBsdHRuZ19lbmFibGVfY2hhbm5lbChoYW5kbGUsICZhbXA7Y2hhbik7PGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgaWYgKHJldCAmbHQ7IDApIHs8YnI+DQpAQCAtMjg4LDE5ICszMTYs
MTkgQEAgc3RhdGljIGludCBlbmFibGVfY2hhbm5lbChjaGFyICpzZXNzaW9uX25hbWUpPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2FzZSBMVFROR19FUlJfS0VSTl9D
SEFOX0VYSVNUOjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNhc2Ug
TFRUTkdfRVJSX1VTVF9DSEFOX0VYSVNUOjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGNhc2UgTFRUTkdfRVJSX0NIQU5fRVhJU1Q6PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgV0FSTigmcXVvdDtDaGFubmVsICVzOiAl
cyAoc2Vzc2lvbiAlcykmcXVvdDssIGNoYW5uZWxfbmFtZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBXQVJOKCZxdW90O0NoYW5uZWwgJXM6ICVz
IChzZXNzaW9uICVzKSZxdW90OywgPGEgaHJlZj0iaHR0cDovL2NoYW4ubmFtZSIgdGFyZ2V0PSJf
YmxhbmsiPmNoYW4ubmFtZTwvYT4sPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbHR0bmdfc3RyZXJyb3Io
cmV0KSwgc2Vzc2lvbl9uYW1lKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCB3YXJuID0gMTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBicmVhazs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBkZWZhdWx0Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoEVSUigmcXVvdDtDaGFubmVsICVzOiAlcyAoc2Vzc2lvbiAlcykm
cXVvdDssIGNoYW5uZWxfbmFtZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBFUlIoJnF1b3Q7Q2hhbm5lbCAlczogJXMgKHNlc3Npb24gJXMpJnF1
b3Q7LCA8YSBocmVmPSJodHRwOi8vY2hhbi5uYW1lIiB0YXJnZXQ9Il9ibGFuayI+Y2hhbi5uYW1l
PC9hPiw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsdHRuZ19zdHJlcnJvcihyZXQpLCBzZXNzaW9uX25h
bWUpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGVycm9yID0gMTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBicmVhazs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfSBlbHNlIHs8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBNU0coJnF1b3Q7JXMgY2hhbm5lbCAlcyBlbmFibGVkIGZv
ciBzZXNzaW9uICVzJnF1b3Q7LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdldF9kb21haW5fc3RyKGRvbS50eXBlKSwgY2hh
bm5lbF9uYW1lLCBzZXNzaW9uX25hbWUpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdldF9kb21haW5fc3RyKGRvbS50eXBl
KSwgPGEgaHJlZj0iaHR0cDovL2NoYW4ubmFtZSIgdGFyZ2V0PSJfYmxhbmsiPmNoYW4ubmFtZTwv
YT4sIHNlc3Npb25fbmFtZSk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgc3VjY2VzcyA9IDE7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCjxzcGFu
IGNsYXNzPSJIT0VuWmIiPjxmb250IGNvbG9yPSIjODg4ODg4Ij48YnI+DQotLTxicj4NCjIuMS4z
PGJyPg0KPGJyPg0KPGJyPg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX188YnI+DQpsdHRuZy1kZXYgbWFpbGluZyBsaXN0PGJyPg0KPGEgaHJlZj0ibWFpbHRv
Omx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmciPmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc8L2E+
PGJyPg0KPGEgaHJlZj0iaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2IiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2PC9hPjxicj4NCjwvZm9udD48L3NwYW4+
PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48YnIgY2xlYXI9ImFsbCI+PGRpdj48YnI+PC9kaXY+LS0g
PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+Sm9uYXRoYW4g
UmFqb3R0ZSBKdWxpZW48L2Rpdj48L2Rpdj4NCjwvZGl2PjwvZGl2PjwvZGl2Pg0K
--089e01229e861af1bb0508cefd73--


--===============0603764301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0603764301==--
