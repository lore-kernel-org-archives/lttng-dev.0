From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [GSOC14]Can I Fix Bug #709 in this way?
Date: Mon, 17 Mar 2014 14:42:15 -0400
Message-ID: <CA+jJMxupK6q41_VOB0nCDGfoGtA7mi=ag8JPRE5sp6h6w5O_Zg__12401.3360626579$1395081807$gmane$org@mail.gmail.com>
References: <CANK7Sy9pHm+HQn+mwLEHFqaxpDa86k7H_TSys7QjYeUSK2oOaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WPcUP-0000l3-7v
	for lttng-dev@lists.lttng.org; Mon, 17 Mar 2014 14:42:26 -0400
Received: by mail-qc0-f181.google.com with SMTP id e9so6510163qcy.12
	for <lttng-dev@lists.lttng.org>; Mon, 17 Mar 2014 11:42:15 -0700 (PDT)
In-Reply-To: <CANK7Sy9pHm+HQn+mwLEHFqaxpDa86k7H_TSys7QjYeUSK2oOaw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yue Liu <liuyue0310@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

The fix looks good!
Note that the "path" variable must be declared at the beginning of the
function to comply with our coding standards.

Also, please have a look at the contributor's guide[1] and run the
checkpatch.pl script to submit the patch in the appropriate format.

Regards,
J=E9r=E9mie

[1] https://raw.github.com/jgalar/lttng-doc/master/contributor-guide.txt

On Sun, Mar 16, 2014 at 8:25 AM, Yue Liu <liuyue0310@gmail.com> wrote:
> Hi,
>     I want to submit some patches before writing my GSOC14 Proposals.
>     For Bug #709, I have read the source code, and found there may be more
> bugs in the func config_get_section_entries()(In src/common/config/config=
.c
> line 191.):
>         1.No fclose(FILE*) after fopen(FILE*).
>         2.May be the second DEFAULT_DAEMON_HOME_CONFIGPATH macro (config.c
> line 230) is incorrectly written. It should be
> DEFAULT_DAEMON_SYSTEM_CONFIGPATH.
>
>     According the description of Bug #709, I wrote the patches of this bug
> as follows:
>     1.I used func "ini_parse()" instead of "ini_parse_file()",  ini_parse=
()
> will close the file when it's finished.
>     2.The order of the configuration files is 1) System Wide
> (/etc/lttng/lttng.conf); 2) Local ($HOME/.lttng/lttng.conf); 3) Command l=
ine
> argument. Simply use the ini_parese() func to get the config info, and wr=
ite
> back to filter struct, and update. I hope it will work.
>     3.I move the DBG() and ERR()  to func "ini_parse()"(ini.c), for debug
> and error infos. Just because I don't know where to put it will be better.
>     I don't know whether it is correct and I hope to get some suggestion =
and
> guidance from you:
>
> diff --git a/src/common/config/config.c b/src/common/config/config.c
> index 04bd2fd..40ae52d 100644
> --- a/src/common/config/config.c
> +++ b/src/common/config/config.c
> @@ -192,53 +192,35 @@ int config_get_section_entries(const char
> *override_path, const char *section,
>   config_entry_handler_cb handler, void *user_data)
>  {
>   int ret =3D 0;
> - FILE *config_file =3D NULL;
>   struct handler_filter_args filter =3D { section, handler, user_data };
>
> - if (override_path) {
> - config_file =3D fopen(override_path, "r");
> - if (config_file) {
> - DBG("Loaded daemon configuration file at %s",
> - override_path);
> - } else {
> - ERR("Failed to open daemon configuration file at %s",
> - override_path);
> - ret =3D -ENOENT;
> - goto end;
> - }
> - } else {
> - char *path =3D utils_get_home_dir();
> +    /* Try to open the system daemon configuration file */
> +    if (access(DEFAULT_DAEMON_SYSTEM_CONFIGPATH, R_OK) =3D=3D 0) {
> +        ret =3D ini_parse(DEFAULT_DAEMON_SYSTEM_CONFIGPATH,
> +                (ini_entry_handler) config_entry_handler_filter, (void *)
> &filter);
> +    }
>
> - /* Try to open the user's daemon configuration file */
> - if (path) {
> - ret =3D asprintf(&path, DEFAULT_DAEMON_HOME_CONFIGPATH, path);
> - if (ret < 0) {
> - goto end;
> - }
> +    char *path =3D utils_get_home_dir();
>
> - ret =3D 0;
> - config_file =3D fopen(path, "r");
> - if (config_file) {
> - DBG("Loaded daemon configuration file at %s", path);
> - }
> +    /* Try to open the user's daemon configuration file */
> +    if (path) {
> +        ret =3D asprintf(&path, DEFAULT_DAEMON_HOME_CONFIGPATH, path);
> +        if (ret < 0) {
> +            goto end;
> +        }
>
> - free(path);
> - }
> +        if (access(path, R_OK) =3D=3D 0) {
> +            ret =3D ini_parse(path,
> +                    (ini_entry_handler) config_entry_handler_filter, (vo=
id
> *) &filter);
> +        }
> +        free(path);
> +    }
>
> - /* Try to open the system daemon configuration file */
> - if (!config_file) {
> - config_file =3D fopen(DEFAULT_DAEMON_HOME_CONFIGPATH, "r");
> - }
> + if (override_path && access(override_path, R_OK) =3D=3D 0) {
> +        ret =3D ini_parse(override_path,
> +                (ini_entry_handler) config_entry_handler_filter, (void *)
> &filter);
>   }
>
> - if (!config_file) {
> - DBG("No daemon configuration file found.");
> - goto end;
> - }
> -
> - ret =3D ini_parse_file(config_file,
> - (ini_entry_handler) config_entry_handler_filter, (void *) &filter);
> -
>  end:
>   return ret;
>  }
> diff --git a/src/common/config/ini.c b/src/common/config/ini.c
> index 7462aeb..f56e3e1 100644
> --- a/src/common/config/ini.c
> +++ b/src/common/config/ini.c
> @@ -35,6 +35,7 @@
>  #include <ctype.h>
>  #include <string.h>
>
> +#include <common/error.h>
>  #include "ini.h"
>
>  #if !INI_USE_STACK
> @@ -206,8 +207,10 @@ int ini_parse(const char* filename, ini_entry_handler
> handler, void* user)
>
>   file =3D fopen(filename, "r");
>   if (!file) {
> +        ERR("Failed to open daemon configuration file at %s", filename);
>   return -1;
>   }
> +    DBG("Loaded daemon configuration file at %s", filename);
>
>   error =3D ini_parse_file(file, handler, user);
>   fclose(file);
>
>
> Best Regards,
> Yue Liu
> ----------------------------------------------------------
> Tsinghua University NISL-Lab(FIT-1-213)
> TEL: 156-5279-8191
> Mail: liuyue0310@gmail.com
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
