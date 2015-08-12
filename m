From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Improve the error
 reporting of the track/untrack command
Date: Wed, 12 Aug 2015 18:59:03 -0400
Message-ID: <CA+jJMxtsOTa_9BBV7fyCG-csMhfor2_b+=Gh1PmXQV8q8=dXMA__19523.7996442758$1439420428$gmane$org@mail.gmail.com>
References: <1439410096-769-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1907076468=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZPezE-0000IJ-LD
 for lttng-dev@lists.lttng.org; Wed, 12 Aug 2015 18:59:18 -0400
Received: by ykdz80 with SMTP id z80so27376506ykd.2
 for <lttng-dev@lists.lttng.org>; Wed, 12 Aug 2015 15:59:03 -0700 (PDT)
In-Reply-To: <1439410096-769-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1907076468==
Content-Type: multipart/alternative; boundary=001a11456cbc3d8b15051d252a69

--001a11456cbc3d8b15051d252a69
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 4:08 PM, Michael Jeanson <mjeanson@efficios.com>
wrote:

> This patch adds feedback when a track/untrack command is successful and
> specific messages on errors. It also changes the behavior when tracking
> an already tracked PID or untracking a PID that is not tracked from an
> error to a warning with a successful exit code.
>
> Fixes: #898
>
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>  include/lttng/lttng-error.h            |  2 ++
>  src/bin/lttng-sessiond/trace-ust.c     |  4 ++--
>  src/bin/lttng/commands/track-untrack.c | 23 +++++++++++++++++++++--
>  src/common/error.c                     |  2 ++
>  4 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/include/lttng/lttng-error.h b/include/lttng/lttng-error.h
> index efdca65..a7746fa 100644
> --- a/include/lttng/lttng-error.h
> +++ b/include/lttng/lttng-error.h
> @@ -134,6 +134,8 @@ enum lttng_error_code {
>         LTTNG_ERR_EXCLUSION_NOMEM        =3D 111, /* Lack of memory while
> processing event exclusions */
>         LTTNG_ERR_INVALID_EVENT_NAME     =3D 112, /* Invalid event name *=
/
>         LTTNG_ERR_INVALID_CHANNEL_NAME   =3D 113, /* Invalid channel name=
 */
> +       LTTNG_ERR_PID_TRACKED            =3D 114, /* PID already tracked =
*/
> +       LTTNG_ERR_PID_NOT_TRACKED        =3D 115, /* PID not tracked */
>
>         /* MUST be last element */
>         LTTNG_ERR_NR,                           /* Last element */
> diff --git a/src/bin/lttng-sessiond/trace-ust.c
> b/src/bin/lttng-sessiond/trace-ust.c
> index 2486696..3881084 100644
> --- a/src/bin/lttng-sessiond/trace-ust.c
> +++ b/src/bin/lttng-sessiond/trace-ust.c
> @@ -656,7 +656,7 @@ int pid_tracker_add_pid(struct ust_pid_tracker
> *pid_tracker, int pid)
>         tracker_node =3D pid_tracker_lookup(pid_tracker, pid, &iter);
>         if (tracker_node) {
>                 /* Already exists. */
> -               retval =3D LTTNG_ERR_INVALID;
> +               retval =3D LTTNG_ERR_PID_TRACKED;
>                 goto end;
>         }
>         tracker_node =3D zmalloc(sizeof(*tracker_node));
> @@ -684,7 +684,7 @@ int pid_tracker_del_pid(struct ust_pid_tracker
> *pid_tracker, int pid)
>         tracker_node =3D pid_tracker_lookup(pid_tracker, pid, &iter);
>         if (!tracker_node) {
>                 /* Not found */
> -               retval =3D LTTNG_ERR_INVALID;
> +               retval =3D LTTNG_ERR_PID_NOT_TRACKED;
>                 goto end;
>         }
>         ret =3D lttng_ht_del(pid_tracker->ht, &iter);
> diff --git a/src/bin/lttng/commands/track-untrack.c
> b/src/bin/lttng/commands/track-untrack.c
> index 9ce8504..b3139c6 100644
> --- a/src/bin/lttng/commands/track-untrack.c
> +++ b/src/bin/lttng/commands/track-untrack.c
> @@ -261,9 +261,28 @@ enum cmd_error_code track_untrack_pid(enum cmd_type
> cmd_type, const char *cmd_st
>                 DBG("%s PID %d", cmd_str, pid_list[i]);
>                 ret =3D lib_func(handle, pid_list[i]);
>                 if (ret) {
> -                       success =3D 0;
> -                       retval =3D CMD_ERROR;
> +                       switch (-ret) {
> +                       case LTTNG_ERR_PID_TRACKED:
> +                               WARN("PID %i already tracked in session
> %s",
> +                                               pid_list[i], session_name=
);
> +                               success =3D 1;
> +                               retval =3D CMD_SUCCESS;
> +                               break;
> +                       case LTTNG_ERR_PID_NOT_TRACKED:
> +                               WARN("PID %i not tracked in session %s",
> +                                               pid_list[i], session_name=
);
> +                               success =3D 1;
> +                               retval =3D CMD_SUCCESS;
>

I'm wondering if untracking a PID that was not being tracked should be
reported as an error... Thoughts anyone?

J=C3=A9r=C3=A9mie


> +                               break;
> +                       default:
> +                               ERR("%s", lttng_strerror(ret));
> +                               success =3D 0;
> +                               retval =3D CMD_ERROR;
> +                               break;
> +                       }
>                 } else {
> +                       MSG("PID %i %sed in session %s",
> +                                       pid_list[i], cmd_str,
> session_name);
>                         success =3D 1;
>                 }
>
> diff --git a/src/common/error.c b/src/common/error.c
> index d3e3b94..ad0ac51 100644
> --- a/src/common/error.c
> +++ b/src/common/error.c
> @@ -167,6 +167,8 @@ static const char *error_string_array[] =3D {
>         [ ERROR_INDEX(LTTNG_ERR_MI_NOT_IMPLEMENTED) ] =3D "Mi feature not
> implemented",
>         [ ERROR_INDEX(LTTNG_ERR_INVALID_EVENT_NAME) ] =3D "Invalid event
> name",
>         [ ERROR_INDEX(LTTNG_ERR_INVALID_CHANNEL_NAME) ] =3D "Invalid chan=
nel
> name",
> +       [ ERROR_INDEX(LTTNG_ERR_PID_TRACKED) ] =3D "PID already tracked",
> +       [ ERROR_INDEX(LTTNG_ERR_PID_NOT_TRACKED) ] =3D "PID not tracked",
>
>         /* Last element */
>         [ ERROR_INDEX(LTTNG_ERR_NR) ] =3D "Unknown error code"
> --
> 1.9.1
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a11456cbc3d8b15051d252a69
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPk9uIFdlZCwgQXVnIDEyLCAyMDE1IGF0IDQ6MDggUE0sIE1pY2hhZWwg
SmVhbnNvbiA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzptamVhbnNvbkBlZmZp
Y2lvcy5jb20iIHRhcmdldD0iX2JsYW5rIj5tamVhbnNvbkBlZmZpY2lvcy5jb208L2E+Jmd0Ozwv
c3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1h
cmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDox
ZXgiPlRoaXMgcGF0Y2ggYWRkcyBmZWVkYmFjayB3aGVuIGEgdHJhY2svdW50cmFjayBjb21tYW5k
IGlzIHN1Y2Nlc3NmdWwgYW5kPGJyPg0Kc3BlY2lmaWMgbWVzc2FnZXMgb24gZXJyb3JzLiBJdCBh
bHNvIGNoYW5nZXMgdGhlIGJlaGF2aW9yIHdoZW4gdHJhY2tpbmc8YnI+DQphbiBhbHJlYWR5IHRy
YWNrZWQgUElEIG9yIHVudHJhY2tpbmcgYSBQSUQgdGhhdCBpcyBub3QgdHJhY2tlZCBmcm9tIGFu
PGJyPg0KZXJyb3IgdG8gYSB3YXJuaW5nIHdpdGggYSBzdWNjZXNzZnVsIGV4aXQgY29kZS48YnI+
DQo8YnI+DQpGaXhlczogIzg5ODxicj4NCjxicj4NClNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVh
bnNvbiAmbHQ7PGEgaHJlZj0ibWFpbHRvOm1qZWFuc29uQGVmZmljaW9zLmNvbSI+bWplYW5zb25A
ZWZmaWNpb3MuY29tPC9hPiZndDs8YnI+DQotLS08YnI+DQrCoGluY2x1ZGUvbHR0bmcvbHR0bmct
ZXJyb3IuaMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAyICsrPGJyPg0KwqBzcmMvYmluL2x0dG5nLXNl
c3Npb25kL3RyYWNlLXVzdC5jwqAgwqAgwqB8wqAgNCArKy0tPGJyPg0KwqBzcmMvYmluL2x0dG5n
L2NvbW1hbmRzL3RyYWNrLXVudHJhY2suYyB8IDIzICsrKysrKysrKysrKysrKysrKysrKy0tPGJy
Pg0KwqBzcmMvY29tbW9uL2Vycm9yLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzC
oCAyICsrPGJyPg0KwqA0IGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pPGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbHR0bmcvbHR0bmctZXJyb3Iu
aCBiL2luY2x1ZGUvbHR0bmcvbHR0bmctZXJyb3IuaDxicj4NCmluZGV4IGVmZGNhNjUuLmE3NzQ2
ZmEgMTAwNjQ0PGJyPg0KLS0tIGEvaW5jbHVkZS9sdHRuZy9sdHRuZy1lcnJvci5oPGJyPg0KKysr
IGIvaW5jbHVkZS9sdHRuZy9sdHRuZy1lcnJvci5oPGJyPg0KQEAgLTEzNCw2ICsxMzQsOCBAQCBl
bnVtIGx0dG5nX2Vycm9yX2NvZGUgezxicj4NCsKgIMKgIMKgIMKgIExUVE5HX0VSUl9FWENMVVNJ
T05fTk9NRU3CoCDCoCDCoCDCoCA9IDExMSwgLyogTGFjayBvZiBtZW1vcnkgd2hpbGUgcHJvY2Vz
c2luZyBldmVudCBleGNsdXNpb25zICovPGJyPg0KwqAgwqAgwqAgwqAgTFRUTkdfRVJSX0lOVkFM
SURfRVZFTlRfTkFNRcKgIMKgIMKgPSAxMTIsIC8qIEludmFsaWQgZXZlbnQgbmFtZSAqLzxicj4N
CsKgIMKgIMKgIMKgIExUVE5HX0VSUl9JTlZBTElEX0NIQU5ORUxfTkFNRcKgIMKgPSAxMTMsIC8q
IEludmFsaWQgY2hhbm5lbCBuYW1lICovPGJyPg0KK8KgIMKgIMKgIMKgTFRUTkdfRVJSX1BJRF9U
UkFDS0VEwqAgwqAgwqAgwqAgwqAgwqAgPSAxMTQsIC8qIFBJRCBhbHJlYWR5IHRyYWNrZWQgKi88
YnI+DQorwqAgwqAgwqAgwqBMVFROR19FUlJfUElEX05PVF9UUkFDS0VEwqAgwqAgwqAgwqAgPSAx
MTUsIC8qIFBJRCBub3QgdHJhY2tlZCAqLzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIC8qIE1VU1Qg
YmUgbGFzdCBlbGVtZW50ICovPGJyPg0KwqAgwqAgwqAgwqAgTFRUTkdfRVJSX05SLMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogTGFzdCBlbGVtZW50ICovPGJyPg0K
ZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdHJhY2UtdXN0LmMgYi9zcmMvYmlu
L2x0dG5nLXNlc3Npb25kL3RyYWNlLXVzdC5jPGJyPg0KaW5kZXggMjQ4NjY5Ni4uMzg4MTA4NCAx
MDA2NDQ8YnI+DQotLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3RyYWNlLXVzdC5jPGJyPg0K
KysrIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC90cmFjZS11c3QuYzxicj4NCkBAIC02NTYsNyAr
NjU2LDcgQEAgaW50IHBpZF90cmFja2VyX2FkZF9waWQoc3RydWN0IHVzdF9waWRfdHJhY2tlciAq
cGlkX3RyYWNrZXIsIGludCBwaWQpPGJyPg0KwqAgwqAgwqAgwqAgdHJhY2tlcl9ub2RlID0gcGlk
X3RyYWNrZXJfbG9va3VwKHBpZF90cmFja2VyLCBwaWQsICZhbXA7aXRlcik7PGJyPg0KwqAgwqAg
wqAgwqAgaWYgKHRyYWNrZXJfbm9kZSkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8q
IEFscmVhZHkgZXhpc3RzLiAqLzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHZhbCA9
IExUVE5HX0VSUl9JTlZBTElEOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHZhbCA9
IExUVE5HX0VSUl9QSURfVFJBQ0tFRDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3Rv
IGVuZDs8YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KwqAgwqAgwqAgwqAgdHJhY2tlcl9ub2RlID0g
em1hbGxvYyhzaXplb2YoKnRyYWNrZXJfbm9kZSkpOzxicj4NCkBAIC02ODQsNyArNjg0LDcgQEAg
aW50IHBpZF90cmFja2VyX2RlbF9waWQoc3RydWN0IHVzdF9waWRfdHJhY2tlciAqcGlkX3RyYWNr
ZXIsIGludCBwaWQpPGJyPg0KwqAgwqAgwqAgwqAgdHJhY2tlcl9ub2RlID0gcGlkX3RyYWNrZXJf
bG9va3VwKHBpZF90cmFja2VyLCBwaWQsICZhbXA7aXRlcik7PGJyPg0KwqAgwqAgwqAgwqAgaWYg
KCF0cmFja2VyX25vZGUpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAvKiBOb3QgZm91
bmQgKi88YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR2YWwgPSBMVFROR19FUlJfSU5W
QUxJRDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR2YWwgPSBMVFROR19FUlJfUElE
X05PVF9UUkFDS0VEOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZW5kOzxicj4N
CsKgIMKgIMKgIMKgIH08YnI+DQrCoCDCoCDCoCDCoCByZXQgPSBsdHRuZ19odF9kZWwocGlkX3Ry
YWNrZXItJmd0O2h0LCAmYW1wO2l0ZXIpOzxicj4NCmRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5n
L2NvbW1hbmRzL3RyYWNrLXVudHJhY2suYyBiL3NyYy9iaW4vbHR0bmcvY29tbWFuZHMvdHJhY2st
dW50cmFjay5jPGJyPg0KaW5kZXggOWNlODUwNC4uYjMxMzljNiAxMDA2NDQ8YnI+DQotLS0gYS9z
cmMvYmluL2x0dG5nL2NvbW1hbmRzL3RyYWNrLXVudHJhY2suYzxicj4NCisrKyBiL3NyYy9iaW4v
bHR0bmcvY29tbWFuZHMvdHJhY2stdW50cmFjay5jPGJyPg0KQEAgLTI2MSw5ICsyNjEsMjggQEAg
ZW51bSBjbWRfZXJyb3JfY29kZSB0cmFja191bnRyYWNrX3BpZChlbnVtIGNtZF90eXBlIGNtZF90
eXBlLCBjb25zdCBjaGFyICpjbWRfc3Q8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBEQkco
JnF1b3Q7JXMgUElEICVkJnF1b3Q7LCBjbWRfc3RyLCBwaWRfbGlzdFtpXSk7PGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgcmV0ID0gbGliX2Z1bmMoaGFuZGxlLCBwaWRfbGlzdFtpXSk7PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHJldCkgezxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN1Y2Nlc3MgPSAwOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHJldHZhbCA9IENNRF9FUlJPUjs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzd2l0Y2ggKC1yZXQpIHs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIExUVE5HX0VSUl9QSURfVFJBQ0tFRDo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBXQVJOKCZxdW90
O1BJRCAlaSBhbHJlYWR5IHRyYWNrZWQgaW4gc2Vzc2lvbiAlcyZxdW90Oyw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBwaWRfbGlzdFtpXSwgc2Vzc2lvbl9uYW1lKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdWNjZXNzID0gMTs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR2YWwgPSBDTURfU1VD
Q0VTUzs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIExU
VE5HX0VSUl9QSURfTk9UX1RSQUNLRUQ6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgV0FSTigmcXVvdDtQSUQgJWkgbm90IHRyYWNrZWQgaW4gc2Vz
c2lvbiAlcyZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwaWRfbGlzdFtpXSwgc2Vzc2lvbl9u
YW1lKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBzdWNjZXNzID0gMTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXR2YWwgPSBDTURfU1VDQ0VTUzs8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJy
PjwvZGl2PjxkaXY+SSYjMzk7bSB3b25kZXJpbmcgaWYgdW50cmFja2luZyBhIFBJRCB0aGF0IHdh
cyBub3QgYmVpbmcgdHJhY2tlZCBzaG91bGQgYmUgcmVwb3J0ZWQgYXMgYW4gZXJyb3IuLi4gVGhv
dWdodHMgYW55b25lPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SsOpcsOpbWllPC9kaXY+PGRp
dj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
IDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGVmYXVsdDo8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBFUlIoJnF1b3Q7JXMm
cXVvdDssIGx0dG5nX3N0cmVycm9yKHJldCkpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN1Y2Nlc3MgPSAwOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHZhbCA9IENNRF9FUlJPUjs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgfSBlbHNlIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBNU0coJnF1b3Q7UElEICVpICVzZWQgaW4gc2Vzc2lvbiAlcyZxdW90Oyw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBwaWRfbGlzdFtpXSwgY21kX3N0ciwgc2Vzc2lvbl9uYW1lKTs8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzdWNjZXNzID0gMTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB9PGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL3NyYy9jb21tb24vZXJyb3IuYyBiL3Ny
Yy9jb21tb24vZXJyb3IuYzxicj4NCmluZGV4IGQzZTNiOTQuLmFkMGFjNTEgMTAwNjQ0PGJyPg0K
LS0tIGEvc3JjL2NvbW1vbi9lcnJvci5jPGJyPg0KKysrIGIvc3JjL2NvbW1vbi9lcnJvci5jPGJy
Pg0KQEAgLTE2Nyw2ICsxNjcsOCBAQCBzdGF0aWMgY29uc3QgY2hhciAqZXJyb3Jfc3RyaW5nX2Fy
cmF5W10gPSB7PGJyPg0KwqAgwqAgwqAgwqAgWyBFUlJPUl9JTkRFWChMVFROR19FUlJfTUlfTk9U
X0lNUExFTUVOVEVEKSBdID0gJnF1b3Q7TWkgZmVhdHVyZSBub3QgaW1wbGVtZW50ZWQmcXVvdDss
PGJyPg0KwqAgwqAgwqAgwqAgWyBFUlJPUl9JTkRFWChMVFROR19FUlJfSU5WQUxJRF9FVkVOVF9O
QU1FKSBdID0gJnF1b3Q7SW52YWxpZCBldmVudCBuYW1lJnF1b3Q7LDxicj4NCsKgIMKgIMKgIMKg
IFsgRVJST1JfSU5ERVgoTFRUTkdfRVJSX0lOVkFMSURfQ0hBTk5FTF9OQU1FKSBdID0gJnF1b3Q7
SW52YWxpZCBjaGFubmVsIG5hbWUmcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgWyBFUlJPUl9JTkRF
WChMVFROR19FUlJfUElEX1RSQUNLRUQpIF0gPSAmcXVvdDtQSUQgYWxyZWFkeSB0cmFja2VkJnF1
b3Q7LDxicj4NCivCoCDCoCDCoCDCoFsgRVJST1JfSU5ERVgoTFRUTkdfRVJSX1BJRF9OT1RfVFJB
Q0tFRCkgXSA9ICZxdW90O1BJRCBub3QgdHJhY2tlZCZxdW90Oyw8YnI+DQo8YnI+DQrCoCDCoCDC
oCDCoCAvKiBMYXN0IGVsZW1lbnQgKi88YnI+DQrCoCDCoCDCoCDCoCBbIEVSUk9SX0lOREVYKExU
VE5HX0VSUl9OUikgXSA9ICZxdW90O1Vua25vd24gZXJyb3IgY29kZSZxdW90Ozxicj4NCjxzcGFu
IGNsYXNzPSJIT0VuWmIiPjxmb250IGNvbG9yPSIjODg4ODg4Ij4tLTxicj4NCjEuOS4xPGJyPg0K
PGJyPg0KPC9mb250Pjwvc3Bhbj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjxiciBjbGVhcj0iYWxs
Ij48ZGl2Pjxicj48L2Rpdj4tLSA8YnI+PGRpdiBjbGFzcz0iZ21haWxfc2lnbmF0dXJlIj5Kw6ly
w6ltaWUgR2FsYXJuZWF1PGJyPkVmZmljaU9TIEluYy48YnI+PGEgaHJlZj0iaHR0cDovL3d3dy5l
ZmZpY2lvcy5jb20iIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vd3d3LmVmZmljaW9zLmNvbTwvYT48
L2Rpdj4NCjwvZGl2PjwvZGl2Pg0K
--001a11456cbc3d8b15051d252a69--


--===============1907076468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1907076468==--
