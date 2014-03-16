From: Yue Liu <liuyue0310@gmail.com>
Subject: [GSOC14]Can I Fix Bug #709 in this way?
Date: Sun, 16 Mar 2014 20:25:44 +0800
Message-ID: <CANK7Sy9pHm+HQn+mwLEHFqaxpDa86k7H_TSys7QjYeUSK2oOaw__10411.819528281$1394972797$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0781163089=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <liuyue0310@gmail.com>) id 1WPA8U-0003D0-97
	for lttng-dev@lists.lttng.org; Sun, 16 Mar 2014 08:25:51 -0400
Received: by mail-ig0-f169.google.com with SMTP id h18so5576660igc.0
	for <lttng-dev@lists.lttng.org>; Sun, 16 Mar 2014 05:25:44 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0781163089==
Content-Type: multipart/alternative; boundary=047d7bd74a2ceafea804f4b8668a

--047d7bd74a2ceafea804f4b8668a
Content-Type: text/plain; charset=ISO-8859-1

Hi,
    I want to submit some patches before writing my GSOC14 Proposals.
    For Bug #709, I have read the source code, and found there may be more
bugs in the func config_get_section_entries()(In src/common/config/config.c
line 191.):
        1.No fclose(FILE*) after fopen(FILE*).
        2.May be the second DEFAULT_DAEMON_HOME_CONFIGPATH macro (config.c
line 230) is incorrectly written. It should be
DEFAULT_DAEMON_SYSTEM_CONFIGPATH.

    According the description of Bug #709, I wrote the patches of this bug
as follows:
    1.I used func "ini_parse()" instead of "ini_parse_file()",  ini_parse()
will close the file when it's finished.
    2.The order of the configuration files is 1) System Wide
(/etc/lttng/lttng.conf); 2) Local ($HOME/.lttng/lttng.conf); 3) Command
line argument. Simply use the ini_parese() func to get the config info, and
write back to filter struct, and update. I hope it will work.
    3.I move the DBG() and ERR()  to func "ini_parse()"(ini.c), for debug
and error infos. Just because I don't know where to put it will be better.
    I don't know whether it is correct and I hope to get some suggestion
and guidance from you:

diff --git a/src/common/config/config.c b/src/common/config/config.c
index 04bd2fd..40ae52d 100644
--- a/src/common/config/config.c
+++ b/src/common/config/config.c
@@ -192,53 +192,35 @@ int config_get_section_entries(const char
*override_path, const char *section,
  config_entry_handler_cb handler, void *user_data)
 {
  int ret = 0;
- FILE *config_file = NULL;
  struct handler_filter_args filter = { section, handler, user_data };

- if (override_path) {
- config_file = fopen(override_path, "r");
- if (config_file) {
- DBG("Loaded daemon configuration file at %s",
- override_path);
- } else {
- ERR("Failed to open daemon configuration file at %s",
- override_path);
- ret = -ENOENT;
- goto end;
- }
- } else {
- char *path = utils_get_home_dir();
+    /* Try to open the system daemon configuration file */
+    if (access(DEFAULT_DAEMON_SYSTEM_CONFIGPATH, R_OK) == 0) {
+        ret = ini_parse(DEFAULT_DAEMON_SYSTEM_CONFIGPATH,
+                (ini_entry_handler) config_entry_handler_filter, (void *)
&filter);
+    }

- /* Try to open the user's daemon configuration file */
- if (path) {
- ret = asprintf(&path, DEFAULT_DAEMON_HOME_CONFIGPATH, path);
- if (ret < 0) {
- goto end;
- }
+    char *path = utils_get_home_dir();

- ret = 0;
- config_file = fopen(path, "r");
- if (config_file) {
- DBG("Loaded daemon configuration file at %s", path);
- }
+    /* Try to open the user's daemon configuration file */
+    if (path) {
+        ret = asprintf(&path, DEFAULT_DAEMON_HOME_CONFIGPATH, path);
+        if (ret < 0) {
+            goto end;
+        }

- free(path);
- }
+        if (access(path, R_OK) == 0) {
+            ret = ini_parse(path,
+                    (ini_entry_handler) config_entry_handler_filter, (void
*) &filter);
+        }
+        free(path);
+    }

- /* Try to open the system daemon configuration file */
- if (!config_file) {
- config_file = fopen(DEFAULT_DAEMON_HOME_CONFIGPATH, "r");
- }
+ if (override_path && access(override_path, R_OK) == 0) {
+        ret = ini_parse(override_path,
+                (ini_entry_handler) config_entry_handler_filter, (void *)
&filter);
  }

- if (!config_file) {
- DBG("No daemon configuration file found.");
- goto end;
- }
-
- ret = ini_parse_file(config_file,
- (ini_entry_handler) config_entry_handler_filter, (void *) &filter);
-
 end:
  return ret;
 }
diff --git a/src/common/config/ini.c b/src/common/config/ini.c
index 7462aeb..f56e3e1 100644
--- a/src/common/config/ini.c
+++ b/src/common/config/ini.c
@@ -35,6 +35,7 @@
 #include <ctype.h>
 #include <string.h>

+#include <common/error.h>
 #include "ini.h"

 #if !INI_USE_STACK
@@ -206,8 +207,10 @@ int ini_parse(const char* filename, ini_entry_handler
handler, void* user)

  file = fopen(filename, "r");
  if (!file) {
+        ERR("Failed to open daemon configuration file at %s", filename);
  return -1;
  }
+    DBG("Loaded daemon configuration file at %s", filename);

  error = ini_parse_file(file, handler, user);
  fclose(file);


Best Regards,
Yue Liu
----------------------------------------------------------
Tsinghua University NISL-Lab(FIT-1-213)
TEL: 156-5279-8191
Mail: liuyue0310@gmail.com

<liuyue0310@gmail.com>

--047d7bd74a2ceafea804f4b8668a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,</div><div>=A0 =A0 I want to submit some patc=
hes before writing my GSOC14 Proposals.</div><div>=A0 =A0 For Bug #709, I h=
ave read the source code, and found there may be more bugs in the func conf=
ig_get_section_entries()(In src/common/config/config.c line 191.):</div>
<div>=A0 =A0 =A0 =A0 1.No fclose(FILE*) after fopen(FILE*).</div><div>=A0 =
=A0 =A0 =A0 2.May be the second DEFAULT_DAEMON_HOME_CONFIGPATH macro (confi=
g.c line 230) is incorrectly written. It should be DEFAULT_DAEMON_SYSTEM_CO=
NFIGPATH.</div>
<div>=A0 =A0=A0</div><div>=A0 =A0 According the description of Bug #709, I =
wrote the patches of this bug as follows:</div><div>=A0 =A0 1.I used func &=
quot;ini_parse()&quot; instead of &quot;ini_parse_file()&quot;, =A0ini_pars=
e() will close the file when it&#39;s finished.</div>
<div>=A0 =A0 2.The order of the configuration files is 1) System Wide (/etc=
/lttng/lttng.conf); 2) Local ($HOME/.lttng/lttng.conf); 3) Command line arg=
ument. Simply use the ini_parese() func to get the config info, and write b=
ack to filter struct, and update. I hope it will work.</div>
<div>=A0 =A0 3.I move the DBG() and ERR() =A0to func &quot;ini_parse()&quot=
;(ini.c), for debug and error infos. Just because I don&#39;t know where to=
 put it will be better. =A0</div><div>=A0 =A0 I don&#39;t know whether it i=
s correct and I hope to get some suggestion and guidance from you:</div>
<div><br></div><div>diff --git a/src/common/config/config.c b/src/common/co=
nfig/config.c</div><div>index 04bd2fd..40ae52d 100644</div><div>--- a/src/c=
ommon/config/config.c</div><div>+++ b/src/common/config/config.c</div><div>
@@ -192,53 +192,35 @@ int config_get_section_entries(const char *override_p=
ath, const char *section,</div><div>=A0<span class=3D"" style=3D"white-spac=
e:pre">		</span>config_entry_handler_cb handler, void *user_data)</div><div=
>=A0{</div>
<div>=A0<span class=3D"" style=3D"white-space:pre">	</span>int ret =3D 0;</=
div><div>-<span class=3D"" style=3D"white-space:pre">	</span>FILE *config_f=
ile =3D NULL;</div><div>=A0<span class=3D"" style=3D"white-space:pre">	</sp=
an>struct handler_filter_args filter =3D { section, handler, user_data };</=
div>
<div>=A0</div><div>-<span class=3D"" style=3D"white-space:pre">	</span>if (=
override_path) {</div><div>-<span class=3D"" style=3D"white-space:pre">		</=
span>config_file =3D fopen(override_path, &quot;r&quot;);</div><div>-<span =
class=3D"" style=3D"white-space:pre">		</span>if (config_file) {</div>
<div>-<span class=3D"" style=3D"white-space:pre">			</span>DBG(&quot;Loaded=
 daemon configuration file at %s&quot;,</div><div>-<span class=3D"" style=
=3D"white-space:pre">				</span>override_path);</div><div>-<span class=3D""=
 style=3D"white-space:pre">		</span>} else {</div>
<div>-<span class=3D"" style=3D"white-space:pre">			</span>ERR(&quot;Failed=
 to open daemon configuration file at %s&quot;,</div><div>-<span class=3D""=
 style=3D"white-space:pre">				</span>override_path);</div><div>-<span clas=
s=3D"" style=3D"white-space:pre">			</span>ret =3D -ENOENT;</div>
<div>-<span class=3D"" style=3D"white-space:pre">			</span>goto end;</div><=
div>-<span class=3D"" style=3D"white-space:pre">		</span>}</div><div>-<span=
 class=3D"" style=3D"white-space:pre">	</span>} else {</div><div>-<span cla=
ss=3D"" style=3D"white-space:pre">		</span>char *path =3D utils_get_home_di=
r();</div>
<div>+ =A0 =A0/* Try to open the system daemon configuration file */</div><=
div>+ =A0 =A0if (access(DEFAULT_DAEMON_SYSTEM_CONFIGPATH, R_OK) =3D=3D 0) {=
</div><div>+ =A0 =A0 =A0 =A0ret =3D ini_parse(DEFAULT_DAEMON_SYSTEM_CONFIGP=
ATH,</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(ini_entry_handler) config_=
entry_handler_filter, (void *) &amp;filter);</div>
<div>+ =A0 =A0}</div><div>=A0</div><div>-<span class=3D"" style=3D"white-sp=
ace:pre">		</span>/* Try to open the user&#39;s daemon configuration file *=
/</div><div>-<span class=3D"" style=3D"white-space:pre">		</span>if (path) =
{</div><div>
-<span class=3D"" style=3D"white-space:pre">			</span>ret =3D asprintf(&amp=
;path, DEFAULT_DAEMON_HOME_CONFIGPATH, path);</div><div>-<span class=3D"" s=
tyle=3D"white-space:pre">			</span>if (ret &lt; 0) {</div><div>-<span class=
=3D"" style=3D"white-space:pre">				</span>goto end;</div>
<div>-<span class=3D"" style=3D"white-space:pre">			</span>}</div><div>+ =
=A0 =A0char *path =3D utils_get_home_dir();</div><div>=A0</div><div>-<span =
class=3D"" style=3D"white-space:pre">			</span>ret =3D 0;</div><div>-<span =
class=3D"" style=3D"white-space:pre">			</span>config_file =3D fopen(path, =
&quot;r&quot;);</div>
<div>-<span class=3D"" style=3D"white-space:pre">			</span>if (config_file)=
 {</div><div>-<span class=3D"" style=3D"white-space:pre">				</span>DBG(&qu=
ot;Loaded daemon configuration file at %s&quot;, path);</div><div>-<span cl=
ass=3D"" style=3D"white-space:pre">			</span>}</div>
<div>+ =A0 =A0/* Try to open the user&#39;s daemon configuration file */</d=
iv><div>+ =A0 =A0if (path) {</div><div>+ =A0 =A0 =A0 =A0ret =3D asprintf(&a=
mp;path, DEFAULT_DAEMON_HOME_CONFIGPATH, path);</div><div>+ =A0 =A0 =A0 =A0=
if (ret &lt; 0) {</div>
<div>+ =A0 =A0 =A0 =A0 =A0 =A0goto end;</div><div>+ =A0 =A0 =A0 =A0}</div><=
div>=A0</div><div>-<span class=3D"" style=3D"white-space:pre">			</span>fre=
e(path);</div><div>-<span class=3D"" style=3D"white-space:pre">		</span>}</=
div><div>+ =A0 =A0 =A0 =A0if (access(path, R_OK) =3D=3D 0) {</div>
<div>+ =A0 =A0 =A0 =A0 =A0 =A0ret =3D ini_parse(path,</div><div>+ =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(ini_entry_handler) config_entry_handler_fil=
ter, (void *) &amp;filter);</div><div>+ =A0 =A0 =A0 =A0}</div><div>+ =A0 =
=A0 =A0 =A0free(path);</div><div>+ =A0 =A0}</div><div>
=A0</div><div>-<span class=3D"" style=3D"white-space:pre">		</span>/* Try t=
o open the system daemon configuration file */</div><div>-<span class=3D"" =
style=3D"white-space:pre">		</span>if (!config_file) {</div><div>-<span cla=
ss=3D"" style=3D"white-space:pre">			</span>config_file =3D fopen(DEFAULT_D=
AEMON_HOME_CONFIGPATH, &quot;r&quot;);</div>
<div>-<span class=3D"" style=3D"white-space:pre">		</span>}</div><div>+<spa=
n class=3D"" style=3D"white-space:pre">	</span>if (override_path &amp;&amp;=
 access(override_path, R_OK) =3D=3D 0) {</div><div>+ =A0 =A0 =A0 =A0ret =3D=
 ini_parse(override_path,</div>
<div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(ini_entry_handler) config_entry_hand=
ler_filter, (void *) &amp;filter);</div><div>=A0<span class=3D"" style=3D"w=
hite-space:pre">	</span>}</div><div>=A0</div><div>-<span class=3D"" style=
=3D"white-space:pre">	</span>if (!config_file) {</div>
<div>-<span class=3D"" style=3D"white-space:pre">		</span>DBG(&quot;No daem=
on configuration file found.&quot;);</div><div>-<span class=3D"" style=3D"w=
hite-space:pre">		</span>goto end;</div><div>-<span class=3D"" style=3D"whi=
te-space:pre">	</span>}</div>
<div>-</div><div>-<span class=3D"" style=3D"white-space:pre">	</span>ret =
=3D ini_parse_file(config_file,</div><div>-<span class=3D"" style=3D"white-=
space:pre">			</span>(ini_entry_handler) config_entry_handler_filter, (void=
 *) &amp;filter);</div>
<div>-</div><div>=A0end:</div><div>=A0<span class=3D"" style=3D"white-space=
:pre">	</span>return ret;</div><div>=A0}</div><div>diff --git a/src/common/=
config/ini.c b/src/common/config/ini.c</div><div>index 7462aeb..f56e3e1 100=
644</div>
<div>--- a/src/common/config/ini.c</div><div>+++ b/src/common/config/ini.c<=
/div><div>@@ -35,6 +35,7 @@</div><div>=A0#include &lt;ctype.h&gt;</div><div=
>=A0#include &lt;string.h&gt;</div><div>=A0</div><div>+#include &lt;common/=
error.h&gt;</div>
<div>=A0#include &quot;ini.h&quot;</div><div>=A0</div><div>=A0#if !INI_USE_=
STACK</div><div>@@ -206,8 +207,10 @@ int ini_parse(const char* filename, in=
i_entry_handler handler, void* user)</div><div>=A0</div><div>=A0<span class=
=3D"" style=3D"white-space:pre">	</span>file =3D fopen(filename, &quot;r&qu=
ot;);</div>
<div>=A0<span class=3D"" style=3D"white-space:pre">	</span>if (!file) {</di=
v><div>+ =A0 =A0 =A0 =A0ERR(&quot;Failed to open daemon configuration file =
at %s&quot;, filename);</div><div>=A0<span class=3D"" style=3D"white-space:=
pre">		</span>return -1;</div>
<div>=A0<span class=3D"" style=3D"white-space:pre">	</span>}</div><div>+ =
=A0 =A0DBG(&quot;Loaded daemon configuration file at %s&quot;, filename);</=
div><div>=A0</div><div>=A0<span class=3D"" style=3D"white-space:pre">	</spa=
n>error =3D ini_parse_file(file, handler, user);</div>
<div>=A0<span class=3D"" style=3D"white-space:pre">	</span>fclose(file);</d=
iv><div><br></div></div><div><br></div>Best Regards,<br clear=3D"all"><div>=
<div dir=3D"ltr"><div>Yue Liu</div><div>-----------------------------------=
-----------------------</div>
<div>Tsinghua University NISL-Lab(FIT-1-213)</div><div>TEL: 156-5279-8191</=
div><div>Mail:=A0<a href=3D"mailto:liuyue0310@gmail.com" target=3D"_blank">=
liuyue0310@gmail.com</a></div><div><a href=3D"mailto:liuyue0310@gmail.com" =
target=3D"_blank"><br>
</a></div></div></div>
</div>

--047d7bd74a2ceafea804f4b8668a--


--===============0781163089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0781163089==--
