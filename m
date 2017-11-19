From: =?UTF-8?Q?Adri=C3=A0_Arcarons?= <adria.arcarons@gmail.com>
Subject: Problem compiling on Raspberry Pi 3
Date: Sun, 19 Nov 2017 11:43:03 +0100
Message-ID: <CAL2NQPzhyt4a2ZEGKo0OOiTU20UX754C1HkfYfNvU2wVy6oAJg__38297.0141516582$1511192488$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6157958999798905051=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ot0-x233.google.com (mail-ot0-x233.google.com
 [IPv6:2607:f8b0:4003:c0f::233])
 by lists.lttng.org (Postfix) with ESMTPS id 3yfpN92l2hzhh0
 for <lttng-dev@lists.lttng.org>; Sun, 19 Nov 2017 10:43:05 +0000 (UTC)
Received: by mail-ot0-x233.google.com with SMTP id b54so5448727otd.8
 for <lttng-dev@lists.lttng.org>; Sun, 19 Nov 2017 02:43:05 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============6157958999798905051==
Content-Type: multipart/alternative; boundary="001a1141ad066ed3b3055e53a24c"

--001a1141ad066ed3b3055e53a24c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to compile lttng-ust library on a Raspberry Pi 3 and I get the
following error when make is compiling librinbuffer:

/tmp/ccczexgU.s:2010: Error: selected processor does not support `dmb' in
ARM mode

I guessed the configure script is not detecting my processor correctly.
Raspberry Pi 3 has a Cortex-A53 which is armv8, and has DMB.

To overcome this, I'm specifying additional CFLAGS to force to compile on
the armv8 architecture:

CFLAGS=3D"-mcpu=3Dcortex-a53 -mfloat-abi=3Dhard -mfpu=3Dneon-fp-armv8
-mneon-for-64bits -mtune=3Dcortex-a53" ./configure

Then I run make again. libringbuffer is compiled correctly, but now another
error appears (see the bottom of this mail). I think it's related to
liburcu. It seems lttng-ust-statedump.c is using some macros defined in
hlist.c of the liburcu library, although I can't see no includes of that
file.

Some context:
- I have compiled and installed the v0.7.2 of liburcu on my system.
- gcc version: gcc (Raspbian 6.3.0-18+rpi1) 6.3.0 20170516
- OS: Linux raspberrypi 4.9.35-v7+


The `make` output with the error:

 CC       lttng-ust-statedump.lo
lttng-ust-statedump.c: In function =E2=80=98find_or_create_dl_node=E2=80=99=
:
lttng-ust-statedump.c:179:38: error: =E2=80=98node=E2=80=99 undeclared (fir=
st use in this
function)
  cds_hlist_for_each_entry_2(e, head, node) {
                                      ^~~~
lttng-ust-statedump.c:179:44: error: expected =E2=80=98;=E2=80=99 before =
=E2=80=98{=E2=80=99 token
  cds_hlist_for_each_entry_2(e, head, node) {
                                            ^
lttng-ust-statedump.c:174:7: warning: unused variable =E2=80=98found=E2=80=
=99
[-Wunused-variable]
  bool found =3D false;
       ^~~~~
lttng-ust-statedump.c:193:1: warning: no return statement in function
returning non-void [-Wreturn-type]
 }
 ^
lttng-ust-statedump.c: In function =E2=80=98iter_begin=E2=80=99:
lttng-ust-statedump.c:384:39: error: =E2=80=98node=E2=80=99 undeclared (fir=
st use in this
function)
   cds_hlist_for_each_entry_2(e, head, node)
                                       ^~~~
lttng-ust-statedump.c: In function =E2=80=98iter_end=E2=80=99:
lttng-ust-statedump.c:433:39: error: =E2=80=98node=E2=80=99 undeclared (fir=
st use in this
function)
   cds_hlist_for_each_entry_2(e, head, node) {
                                       ^~~~
lttng-ust-statedump.c:433:45: error: expected =E2=80=98;=E2=80=99 before =
=E2=80=98{=E2=80=99 token
   cds_hlist_for_each_entry_2(e, head, node) {
                                             ^
lttng-ust-statedump.c: In function =E2=80=98ust_dl_table_statedump=E2=80=99=
:
lttng-ust-statedump.c:542:39: error: =E2=80=98node=E2=80=99 undeclared (fir=
st use in this
function)
   cds_hlist_for_each_entry_2(e, head, node) {
                                       ^~~~
lttng-ust-statedump.c:542:45: error: expected =E2=80=98;=E2=80=99 before =
=E2=80=98{=E2=80=99 token
   cds_hlist_for_each_entry_2(e, head, node) {
                                             ^
lttng-ust-statedump.c: In function =E2=80=98ust_dl_state_destroy=E2=80=99:
lttng-ust-statedump.c:642:3: warning: implicit declaration of function
=E2=80=98cds_hlist_for_each_entry_safe_2=E2=80=99 [-Wimplicit-function-decl=
aration]
   cds_hlist_for_each_entry_safe_2(e, tmp, head, node)
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lttng-ust-statedump.c:642:49: error: =E2=80=98node=E2=80=99 undeclared (fir=
st use in this
function)
   cds_hlist_for_each_entry_safe_2(e, tmp, head, node)
                                                 ^~~~
lttng-ust-statedump.c:643:4: error: expected =E2=80=98;=E2=80=99 before =E2=
=80=98free_dl_node=E2=80=99
    free_dl_node(e);
    ^~~~~~~~~~~~
At top level:
lttng-ust-statedump.c:411:6: warning: =E2=80=98trace_lib_unload=E2=80=99 de=
fined but not
used [-Wunused-function]
 void trace_lib_unload(const struct bin_info_data *bin_data, void *ip)
      ^~~~~~~~~~~~~~~~
lttng-ust-statedump.c:390:6: warning: =E2=80=98trace_lib_load=E2=80=99 defi=
ned but not used
[-Wunused-function]
 void trace_lib_load(const struct bin_info_data *bin_data, void *ip)
      ^~~~~~~~~~~~~~
lttng-ust-statedump.c:307:6: warning: =E2=80=98trace_baddr=E2=80=99 defined=
 but not used
[-Wunused-function]
 void trace_baddr(struct bin_info_data *bin_data, void *owner)
      ^~~~~~~~~~~
lttng-ust-statedump.c:196:6: warning: =E2=80=98remove_dl_node=E2=80=99 defi=
ned but not used
[-Wunused-function]
 void remove_dl_node(struct lttng_ust_dl_node *e)
      ^~~~~~~~~~~~~~
lttng-ust-statedump.c:131:5: warning: =E2=80=98compare_bin_data=E2=80=99 de=
fined but not
used [-Wunused-function]
 int compare_bin_data(const struct bin_info_data *a,
     ^~~~~~~~~~~~~~~~
lttng-ust-statedump.c:122:6: warning: =E2=80=98free_dl_node=E2=80=99 define=
d but not used
[-Wunused-function]
 void free_dl_node(struct lttng_ust_dl_node *e)
      ^~~~~~~~~~~~
lttng-ust-statedump.c:84:27: warning: =E2=80=98alloc_dl_node=E2=80=99 defin=
ed but not used
[-Wunused-function]
 struct lttng_ust_dl_node *alloc_dl_node(const struct bin_info_data
*bin_data)
                           ^~~~~~~~~~~~~

--001a1141ad066ed3b3055e53a24c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I&#39;m trying to compile lttng-ust=
 library on a Raspberry Pi 3 and I get the following error when make is com=
piling librinbuffer:</div><div><br></div><div>/tmp/ccczexgU.s:2010: Error: =
selected processor does not support `dmb&#39; in ARM mode<br></div><div><br=
></div><div>I guessed the configure script is not detecting my processor co=
rrectly. Raspberry Pi 3 has a Cortex-A53 which is armv8, and has DMB.=C2=A0=
</div><div><br></div><div>To overcome this, I&#39;m specifying additional C=
FLAGS to force to compile on the armv8 architecture:</div><div><br></div><d=
iv>CFLAGS=3D&quot;-mcpu=3Dcortex-a53 -mfloat-abi=3Dhard -mfpu=3Dneon-fp-arm=
v8 -mneon-for-64bits -mtune=3Dcortex-a53&quot; ./configure<br></div><div><b=
r></div><div>Then I run make again. libringbuffer is compiled correctly, bu=
t now another error appears (see the bottom of this mail). I think it&#39;s=
 related to liburcu. It seems lttng-ust-statedump.c is using some macros de=
fined in hlist.c of the liburcu library, although I can&#39;t see no includ=
es of that file.=C2=A0</div><div><br></div><div>Some context:<br></div><div=
>- I have compiled and installed the v0.7.2 of liburcu on my system.</div><=
div>- gcc version:=C2=A0gcc (Raspbian 6.3.0-18+rpi1) 6.3.0 20170516</div><d=
iv>- OS: Linux raspberrypi 4.9.35-v7+</div><div><br></div><div><br></div><d=
iv>The `make` output with the error:</div><div><br></div><div><div>=C2=A0CC=
=C2=A0 =C2=A0 =C2=A0 =C2=A0lttng-ust-statedump.lo</div><div>lttng-ust-state=
dump.c: In function =E2=80=98find_or_create_dl_node=E2=80=99:</div><div>ltt=
ng-ust-statedump.c:179:38: error: =E2=80=98node=E2=80=99 undeclared (first =
use in this function)<br></div><div>=C2=A0 cds_hlist_for_each_entry_2(e, he=
ad, node) {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ^~~~</div><div>lttng-ust-statedump.c:179:44: error: expected =E2=80=
=98;=E2=80=99 before =E2=80=98{=E2=80=99 token<br></div><div>=C2=A0 cds_hli=
st_for_each_entry_2(e, head, node) {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^</div><div>lttng-ust-=
statedump.c:174:7: warning: unused variable =E2=80=98found=E2=80=99 [-Wunus=
ed-variable]</div><div>=C2=A0 bool found =3D false;</div><div>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0^~~~~</div><div>lttng-ust-statedump.c:193:1: warning: no retu=
rn statement in function returning non-void [-Wreturn-type]</div><div>=C2=
=A0}</div><div>=C2=A0^</div><div>lttng-ust-statedump.c: In function =E2=80=
=98iter_begin=E2=80=99:</div><div>lttng-ust-statedump.c:384:39: error: =E2=
=80=98node=E2=80=99 undeclared (first use in this function)</div><div>=C2=
=A0 =C2=A0cds_hlist_for_each_entry_2(e, head, node)</div><div>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~</div><div>lttng-us=
t-statedump.c: In function =E2=80=98iter_end=E2=80=99:</div><div>lttng-ust-=
statedump.c:433:39: error: =E2=80=98node=E2=80=99 undeclared (first use in =
this function)</div><div>=C2=A0 =C2=A0cds_hlist_for_each_entry_2(e, head, n=
ode) {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0^~~~</div><div>lttng-ust-statedump.c:433:45: error: expected =E2=
=80=98;=E2=80=99 before =E2=80=98{=E2=80=99 token</div><div>=C2=A0 =C2=A0cd=
s_hlist_for_each_entry_2(e, head, node) {</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^</div><d=
iv>lttng-ust-statedump.c: In function =E2=80=98ust_dl_table_statedump=E2=80=
=99:</div><div>lttng-ust-statedump.c:542:39: error: =E2=80=98node=E2=80=99 =
undeclared (first use in this function)</div><div>=C2=A0 =C2=A0cds_hlist_fo=
r_each_entry_2(e, head, node) {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~</div><div>lttng-ust-statedump.c:542:=
45: error: expected =E2=80=98;=E2=80=99 before =E2=80=98{=E2=80=99 token</d=
iv><div>=C2=A0 =C2=A0cds_hlist_for_each_entry_2(e, head, node) {</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0^</div><div>lttng-ust-statedump.c: In function =E2=80=98ust_dl=
_state_destroy=E2=80=99:</div><div>lttng-ust-statedump.c:642:3: warning: im=
plicit declaration of function =E2=80=98cds_hlist_for_each_entry_safe_2=E2=
=80=99 [-Wimplicit-function-declaration]</div><div>=C2=A0 =C2=A0cds_hlist_f=
or_each_entry_safe_2(e, tmp, head, node)</div><div>=C2=A0 =C2=A0^~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~</div><div>lttng-ust-statedump.c:642:49: error: =E2=80=
=98node=E2=80=99 undeclared (first use in this function)</div><div>=C2=A0 =
=C2=A0cds_hlist_for_each_entry_safe_2(e, tmp, head, node)</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0^~~~</div><div>lttng-ust-statedump.c:643:4: error: expe=
cted =E2=80=98;=E2=80=99 before =E2=80=98free_dl_node=E2=80=99</div><div>=
=C2=A0 =C2=A0 free_dl_node(e);</div><div>=C2=A0 =C2=A0 ^~~~~~~~~~~~</div><d=
iv>At top level:</div><div>lttng-ust-statedump.c:411:6: warning: =E2=80=98t=
race_lib_unload=E2=80=99 defined but not used [-Wunused-function]</div><div=
>=C2=A0void trace_lib_unload(const struct bin_info_data *bin_data, void *ip=
)</div><div>=C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~</div><div>lttng-ust-state=
dump.c:390:6: warning: =E2=80=98trace_lib_load=E2=80=99 defined but not use=
d [-Wunused-function]</div><div>=C2=A0void trace_lib_load(const struct bin_=
info_data *bin_data, void *ip)</div><div>=C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~=
~</div><div>lttng-ust-statedump.c:307:6: warning: =E2=80=98trace_baddr=E2=
=80=99 defined but not used [-Wunused-function]</div><div>=C2=A0void trace_=
baddr(struct bin_info_data *bin_data, void *owner)</div><div>=C2=A0 =C2=A0 =
=C2=A0 ^~~~~~~~~~~</div><div>lttng-ust-statedump.c:196:6: warning: =E2=80=
=98remove_dl_node=E2=80=99 defined but not used [-Wunused-function]</div><d=
iv>=C2=A0void remove_dl_node(struct lttng_ust_dl_node *e)</div><div>=C2=A0 =
=C2=A0 =C2=A0 ^~~~~~~~~~~~~~</div><div>lttng-ust-statedump.c:131:5: warning=
: =E2=80=98compare_bin_data=E2=80=99 defined but not used [-Wunused-functio=
n]</div><div>=C2=A0int compare_bin_data(const struct bin_info_data *a,</div=
><div>=C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~</div><div>lttng-ust-statedump.c:=
122:6: warning: =E2=80=98free_dl_node=E2=80=99 defined but not used [-Wunus=
ed-function]</div><div>=C2=A0void free_dl_node(struct lttng_ust_dl_node *e)=
</div><div>=C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~</div><div>lttng-ust-statedump.=
c:84:27: warning: =E2=80=98alloc_dl_node=E2=80=99 defined but not used [-Wu=
nused-function]</div><div>=C2=A0struct lttng_ust_dl_node *alloc_dl_node(con=
st struct bin_info_data *bin_data)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~=
~~~~~~~</div></div><div><br></div></div>

--001a1141ad066ed3b3055e53a24c--

--===============6157958999798905051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6157958999798905051==--
