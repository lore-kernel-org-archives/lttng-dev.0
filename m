From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Problem compiling on Raspberry Pi 3
Date: Mon, 20 Nov 2017 16:24:14 +0000 (UTC)
Message-ID: <400652431.18311.1511195054122.JavaMail.zimbra__14391.7043846615$1511195388$gmane$org@efficios.com>
References: <CAL2NQPzhyt4a2ZEGKo0OOiTU20UX754C1HkfYfNvU2wVy6oAJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2533613370774727053=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3ygZ1W3P3rzhmX
 for <lttng-dev@lists.lttng.org>; Mon, 20 Nov 2017 16:29:35 +0000 (UTC)
In-Reply-To: <CAL2NQPzhyt4a2ZEGKo0OOiTU20UX754C1HkfYfNvU2wVy6oAJg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?utf-8?Q?Adri=C3=A0?= Arcarons <adria.arcarons@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2533613370774727053==
Content-Type: multipart/alternative;
	boundary="=_eaccef8b-d00e-4c9a-a2ef-cd1105e573f9"

--=_eaccef8b-d00e-4c9a-a2ef-cd1105e573f9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Nov 19, 2017, at 5:43 AM, Adri=C3=A0 Arcarons <adria.arcarons@gmai=
l.com> wrote:=20

> Hi,
> I'm trying to compile lttng-ust library on a Raspberry Pi 3 and I get the
> following error when make is compiling librinbuffer:

> /tmp/ccczexgU.s:2010: Error: selected processor does not support `dmb' in=
 ARM
> mode

> I guessed the configure script is not detecting my processor correctly.
> Raspberry Pi 3 has a Cortex-A53 which is armv8, and has DMB.

> To overcome this, I'm specifying additional CFLAGS to force to compile on=
 the
> armv8 architecture:

> CFLAGS=3D"-mcpu=3Dcortex-a53 -mfloat-abi=3Dhard -mfpu=3Dneon-fp-armv8 -mn=
eon-for-64bits
> -mtune=3Dcortex-a53" ./configure

> Then I run make again. libringbuffer is compiled correctly, but now anoth=
er
> error appears (see the bottom of this mail). I think it's related to libu=
rcu.
> It seems lttng-ust-statedump.c is using some macros defined in hlist.c of=
 the
> liburcu library, although I can't see no includes of that file.

> Some context:
> - I have compiled and installed the v0.7.2 of liburcu on my system.
> - gcc version: gcc (Raspbian 6.3.0-18+rpi1) 6.3.0 20170516
> - OS: Linux raspberrypi 4.9.35-v7+

What version of lttng-ust are you building ?=20

Thanks,=20

Mathieu=20

> The `make` output with the error:

> CC lttng-ust-statedump.lo
> lttng-ust-statedump.c: In function =E2=80=98find_or_create_dl_node=E2=80=
=99:
> lttng-ust-statedump.c:179:38: error: =E2=80=98node=E2=80=99 undeclared (f=
irst use in this
> function)
> cds_hlist_for_each_entry_2(e, head, node) {
> ^~~~
> lttng-ust-statedump.c:179:44: error: expected =E2=80=98;=E2=80=99 before =
=E2=80=98{=E2=80=99 token
> cds_hlist_for_each_entry_2(e, head, node) {
> ^
> lttng-ust-statedump.c:174:7: warning: unused variable =E2=80=98found=E2=
=80=99
> [-Wunused-variable]
> bool found =3D false;
> ^~~~~
> lttng-ust-statedump.c:193:1: warning: no return statement in function ret=
urning
> non-void [-Wreturn-type]
> }
> ^
> lttng-ust-statedump.c: In function =E2=80=98iter_begin=E2=80=99:
> lttng-ust-statedump.c:384:39: error: =E2=80=98node=E2=80=99 undeclared (f=
irst use in this
> function)
> cds_hlist_for_each_entry_2(e, head, node)
> ^~~~
> lttng-ust-statedump.c: In function =E2=80=98iter_end=E2=80=99:
> lttng-ust-statedump.c:433:39: error: =E2=80=98node=E2=80=99 undeclared (f=
irst use in this
> function)
> cds_hlist_for_each_entry_2(e, head, node) {
> ^~~~
> lttng-ust-statedump.c:433:45: error: expected =E2=80=98;=E2=80=99 before =
=E2=80=98{=E2=80=99 token
> cds_hlist_for_each_entry_2(e, head, node) {
> ^
> lttng-ust-statedump.c: In function =E2=80=98ust_dl_table_statedump=E2=80=
=99:
> lttng-ust-statedump.c:542:39: error: =E2=80=98node=E2=80=99 undeclared (f=
irst use in this
> function)
> cds_hlist_for_each_entry_2(e, head, node) {
> ^~~~
> lttng-ust-statedump.c:542:45: error: expected =E2=80=98;=E2=80=99 before =
=E2=80=98{=E2=80=99 token
> cds_hlist_for_each_entry_2(e, head, node) {
> ^
> lttng-ust-statedump.c: In function =E2=80=98ust_dl_state_destroy=E2=80=99=
:
> lttng-ust-statedump.c:642:3: warning: implicit declaration of function
> =E2=80=98cds_hlist_for_each_entry_safe_2=E2=80=99 [-Wimplicit-function-de=
claration]
> cds_hlist_for_each_entry_safe_2(e, tmp, head, node)
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lttng-ust-statedump.c:642:49: error: =E2=80=98node=E2=80=99 undeclared (f=
irst use in this
> function)
> cds_hlist_for_each_entry_safe_2(e, tmp, head, node)
> ^~~~
> lttng-ust-statedump.c:643:4: error: expected =E2=80=98;=E2=80=99 before =
=E2=80=98free_dl_node=E2=80=99
> free_dl_node(e);
> ^~~~~~~~~~~~
> At top level:
> lttng-ust-statedump.c:411:6: warning: =E2=80=98trace_lib_unload=E2=80=99 =
defined but not used
> [-Wunused-function]
> void trace_lib_unload(const struct bin_info_data *bin_data, void *ip)
> ^~~~~~~~~~~~~~~~
> lttng-ust-statedump.c:390:6: warning: =E2=80=98trace_lib_load=E2=80=99 de=
fined but not used
> [-Wunused-function]
> void trace_lib_load(const struct bin_info_data *bin_data, void *ip)
> ^~~~~~~~~~~~~~
> lttng-ust-statedump.c:307:6: warning: =E2=80=98trace_baddr=E2=80=99 defin=
ed but not used
> [-Wunused-function]
> void trace_baddr(struct bin_info_data *bin_data, void *owner)
> ^~~~~~~~~~~
> lttng-ust-statedump.c:196:6: warning: =E2=80=98remove_dl_node=E2=80=99 de=
fined but not used
> [-Wunused-function]
> void remove_dl_node(struct lttng_ust_dl_node *e)
> ^~~~~~~~~~~~~~
> lttng-ust-statedump.c:131:5: warning: =E2=80=98compare_bin_data=E2=80=99 =
defined but not used
> [-Wunused-function]
> int compare_bin_data(const struct bin_info_data *a,
> ^~~~~~~~~~~~~~~~
> lttng-ust-statedump.c:122:6: warning: =E2=80=98free_dl_node=E2=80=99 defi=
ned but not used
> [-Wunused-function]
> void free_dl_node(struct lttng_ust_dl_node *e)
> ^~~~~~~~~~~~
> lttng-ust-statedump.c:84:27: warning: =E2=80=98alloc_dl_node=E2=80=99 def=
ined but not used
> [-Wunused-function]
> struct lttng_ust_dl_node *alloc_dl_node(const struct bin_info_data *bin_d=
ata)
> ^~~~~~~~~~~~~

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_eaccef8b-d00e-4c9a-a2ef-cd1105e573f9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><span id=3D"zwchr"=
 data-marker=3D"__DIVIDER__">----- On Nov 19, 2017, at 5:43 AM, Adri=C3=A0 =
Arcarons &lt;adria.arcarons@gmail.com&gt; wrote:<br></span><div data-marker=
=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;mar=
gin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:norm=
al;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12=
pt;"><div dir=3D"ltr">Hi,<br><div>I'm trying to compile lttng-ust library o=
n a Raspberry Pi 3 and I get the following error when make is compiling lib=
rinbuffer:</div><br><div>/tmp/ccczexgU.s:2010: Error: selected processor do=
es not support `dmb' in ARM mode<br></div><br><div>I guessed the configure =
script is not detecting my processor correctly. Raspberry Pi 3 has a Cortex=
-A53 which is armv8, and has DMB.&nbsp;</div><br><div>To overcome this, I'm=
 specifying additional CFLAGS to force to compile on the armv8 architecture=
:</div><br><div>CFLAGS=3D"-mcpu=3Dcortex-a53 -mfloat-abi=3Dhard -mfpu=3Dneo=
n-fp-armv8 -mneon-for-64bits -mtune=3Dcortex-a53" ./configure<br></div><br>=
<div>Then I run make again. libringbuffer is compiled correctly, but now an=
other error appears (see the bottom of this mail). I think it's related to =
liburcu. It seems lttng-ust-statedump.c is using some macros defined in hli=
st.c of the liburcu library, although I can't see no includes of that file.=
&nbsp;</div><br><div>Some context:<br></div><div>- I have compiled and inst=
alled the v0.7.2 of liburcu on my system.</div><div>- gcc version:&nbsp;gcc=
 (Raspbian 6.3.0-18+rpi1) 6.3.0 20170516</div><div>- OS: Linux raspberrypi =
4.9.35-v7+</div></div></blockquote><div><br></div><div>What version of lttn=
g-ust are you building ?<br data-mce-bogus=3D"1"></div><div><br data-mce-bo=
gus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mc=
e-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br dat=
a-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote sty=
le=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:=
#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:=
Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><br><br><div>T=
he `make` output with the error:</div><br><div><div>&nbsp;CC&nbsp; &nbsp; &=
nbsp; &nbsp;lttng-ust-statedump.lo</div><div>lttng-ust-statedump.c: In func=
tion =E2=80=98find_or_create_dl_node=E2=80=99:</div><div>lttng-ust-statedum=
p.c:179:38: error: =E2=80=98node=E2=80=99 undeclared (first use in this fun=
ction)<br></div><div>&nbsp; cds_hlist_for_each_entry_2(e, head, node) {</di=
v><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ^~~~</div>=
<div>lttng-ust-statedump.c:179:44: error: expected =E2=80=98;=E2=80=99 befo=
re =E2=80=98{=E2=80=99 token<br></div><div>&nbsp; cds_hlist_for_each_entry_=
2(e, head, node) {</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; ^</div><div>lttng-ust-statedump.c:174:7: w=
arning: unused variable =E2=80=98found=E2=80=99 [-Wunused-variable]</div><d=
iv>&nbsp; bool found =3D false;</div><div>&nbsp; &nbsp; &nbsp; &nbsp;^~~~~<=
/div><div>lttng-ust-statedump.c:193:1: warning: no return statement in func=
tion returning non-void [-Wreturn-type]</div><div>&nbsp;}</div><div>&nbsp;^=
</div><div>lttng-ust-statedump.c: In function =E2=80=98iter_begin=E2=80=99:=
</div><div>lttng-ust-statedump.c:384:39: error: =E2=80=98node=E2=80=99 unde=
clared (first use in this function)</div><div>&nbsp; &nbsp;cds_hlist_for_ea=
ch_entry_2(e, head, node)</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp;^~~~</div><div>lttng-ust-statedump.c: In function =
=E2=80=98iter_end=E2=80=99:</div><div>lttng-ust-statedump.c:433:39: error: =
=E2=80=98node=E2=80=99 undeclared (first use in this function)</div><div>&n=
bsp; &nbsp;cds_hlist_for_each_entry_2(e, head, node) {</div><div>&nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;^~~~</div><div>lttng-=
ust-statedump.c:433:45: error: expected =E2=80=98;=E2=80=99 before =E2=80=
=98{=E2=80=99 token</div><div>&nbsp; &nbsp;cds_hlist_for_each_entry_2(e, he=
ad, node) {</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp;^</div><div>lttng-ust-statedump.c: In funct=
ion =E2=80=98ust_dl_table_statedump=E2=80=99:</div><div>lttng-ust-statedump=
.c:542:39: error: =E2=80=98node=E2=80=99 undeclared (first use in this func=
tion)</div><div>&nbsp; &nbsp;cds_hlist_for_each_entry_2(e, head, node) {</d=
iv><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;^~~=
~</div><div>lttng-ust-statedump.c:542:45: error: expected =E2=80=98;=E2=80=
=99 before =E2=80=98{=E2=80=99 token</div><div>&nbsp; &nbsp;cds_hlist_for_e=
ach_entry_2(e, head, node) {</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;^</div><div>lttng-ust-stat=
edump.c: In function =E2=80=98ust_dl_state_destroy=E2=80=99:</div><div>lttn=
g-ust-statedump.c:642:3: warning: implicit declaration of function =E2=80=
=98cds_hlist_for_each_entry_safe_2=E2=80=99 [-Wimplicit-function-declaratio=
n]</div><div>&nbsp; &nbsp;cds_hlist_for_each_entry_safe_2(e, tmp, head, nod=
e)</div><div>&nbsp; &nbsp;^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</div><div>lttng-u=
st-statedump.c:642:49: error: =E2=80=98node=E2=80=99 undeclared (first use =
in this function)</div><div>&nbsp; &nbsp;cds_hlist_for_each_entry_safe_2(e,=
 tmp, head, node)</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;^~~~</div><div>lttng-us=
t-statedump.c:643:4: error: expected =E2=80=98;=E2=80=99 before =E2=80=98fr=
ee_dl_node=E2=80=99</div><div>&nbsp; &nbsp; free_dl_node(e);</div><div>&nbs=
p; &nbsp; ^~~~~~~~~~~~</div><div>At top level:</div><div>lttng-ust-statedum=
p.c:411:6: warning: =E2=80=98trace_lib_unload=E2=80=99 defined but not used=
 [-Wunused-function]</div><div>&nbsp;void trace_lib_unload(const struct bin=
_info_data *bin_data, void *ip)</div><div>&nbsp; &nbsp; &nbsp; ^~~~~~~~~~~~=
~~~~</div><div>lttng-ust-statedump.c:390:6: warning: =E2=80=98trace_lib_loa=
d=E2=80=99 defined but not used [-Wunused-function]</div><div>&nbsp;void tr=
ace_lib_load(const struct bin_info_data *bin_data, void *ip)</div><div>&nbs=
p; &nbsp; &nbsp; ^~~~~~~~~~~~~~</div><div>lttng-ust-statedump.c:307:6: warn=
ing: =E2=80=98trace_baddr=E2=80=99 defined but not used [-Wunused-function]=
</div><div>&nbsp;void trace_baddr(struct bin_info_data *bin_data, void *own=
er)</div><div>&nbsp; &nbsp; &nbsp; ^~~~~~~~~~~</div><div>lttng-ust-statedum=
p.c:196:6: warning: =E2=80=98remove_dl_node=E2=80=99 defined but not used [=
-Wunused-function]</div><div>&nbsp;void remove_dl_node(struct lttng_ust_dl_=
node *e)</div><div>&nbsp; &nbsp; &nbsp; ^~~~~~~~~~~~~~</div><div>lttng-ust-=
statedump.c:131:5: warning: =E2=80=98compare_bin_data=E2=80=99 defined but =
not used [-Wunused-function]</div><div>&nbsp;int compare_bin_data(const str=
uct bin_info_data *a,</div><div>&nbsp; &nbsp; &nbsp;^~~~~~~~~~~~~~~~</div><=
div>lttng-ust-statedump.c:122:6: warning: =E2=80=98free_dl_node=E2=80=99 de=
fined but not used [-Wunused-function]</div><div>&nbsp;void free_dl_node(st=
ruct lttng_ust_dl_node *e)</div><div>&nbsp; &nbsp; &nbsp; ^~~~~~~~~~~~</div=
><div>lttng-ust-statedump.c:84:27: warning: =E2=80=98alloc_dl_node=E2=80=99=
 defined but not used [-Wunused-function]</div><div>&nbsp;struct lttng_ust_=
dl_node *alloc_dl_node(const struct bin_info_data *bin_data)</div><div>&nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp;^~~~~~~~~~~~~</div></div><br></div><br>__________________=
_____________________________<br>lttng-dev mailing list<br>lttng-dev@lists.=
lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br>=
</blockquote></div><br><div data-marker=3D"__SIG_POST__">-- <br></div><div>=
Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></=
body></html>
--=_eaccef8b-d00e-4c9a-a2ef-cd1105e573f9--

--===============2533613370774727053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2533613370774727053==--
