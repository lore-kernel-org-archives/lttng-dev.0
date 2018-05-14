From: Anders Wallin <wallinux@gmail.com>
Subject: Re: [PATCH lttng-tools] Tests: Added autoloading
 session test cases
Date: Mon, 14 May 2018 22:52:40 +0200
Message-ID: <CAF2baFfLWQ5KXB3g=R+cVVvKuN4kwXge=9Ci+NhY1Q-QPaRcwA__33602.1567266018$1526331056$gmane$org@mail.gmail.com>
References: <20180514153053.27665-1-wallinux@gmail.com>
 <20180514161658.GB9461@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7596256971950290081=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-x22b.google.com (mail-oi0-x22b.google.com
 [IPv6:2607:f8b0:4003:c06::22b])
 by lists.lttng.org (Postfix) with ESMTPS id 40lCZY4Jdvz18M8
 for <lttng-dev@lists.lttng.org>; Mon, 14 May 2018 16:52:52 -0400 (EDT)
Received: by mail-oi0-x22b.google.com with SMTP id k17-v6so12000739oih.5
 for <lttng-dev@lists.lttng.org>; Mon, 14 May 2018 13:52:52 -0700 (PDT)
In-Reply-To: <20180514161658.GB9461@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============7596256971950290081==
Content-Type: multipart/alternative; boundary="00000000000045c5cc056c30ab34"

--00000000000045c5cc056c30ab34
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I will update the patch and resend it tomorrow

Regards
Anders

m=C3=A5n 14 maj 2018 kl 18:17 skrev Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com>:

> Hi Anders
>
> Thanks for proposing this patch.
>
> We will need more context here. Are those currently failing and exposing =
a
> problem?
>
Yes, lttng-tools 2.10.4 is broken when having auto-load sessions, see
https://lists.lttng.org/pipermail/lttng-dev/2018-May/028014.html

I will add a longer commit message

>
> See comments inline.
>
>
> On Mon, May 14, 2018 at 05:30:53PM +0200, Anders Wallin wrote:
> > Signed-off-by: Anders Wallin <wallinux@gmail.com>
> > ---
> >  tests/fast_regression                         |   1 +
> >  .../regression/tools/save-load/test_autoload  | 101 ++++++++++++++++++
> >  2 files changed, 102 insertions(+)
> >  create mode 100755 tests/regression/tools/save-load/test_autoload
> >
> > diff --git a/tests/fast_regression b/tests/fast_regression
> > index bbce068f..2f02f872 100644
> > --- a/tests/fast_regression
> > +++ b/tests/fast_regression
> > @@ -13,6 +13,7 @@ regression/tools/snapshots/test_ust_fast
> >  regression/tools/snapshots/test_ust_streaming
> >  regression/tools/save-load/test_save
> >  regression/tools/save-load/test_load
> > +regression/tools/save-load/test_autoload
> >  regression/tools/mi/test_mi
> >  regression/tools/wildcard/test_event_wildcard
> >  regression/tools/crash/test_crash
> > diff --git a/tests/regression/tools/save-load/test_autoload
> b/tests/regression/tools/save-load/test_autoload
> > new file mode 100755
> > index 00000000..ea1210de
> > --- /dev/null
> > +++ b/tests/regression/tools/save-load/test_autoload
> > @@ -0,0 +1,101 @@
> > +#!/bin/bash
> > +#
> > +# Copyright (C) - 2014 David Goulet <dgoulet@efficios.com>
>
> I doubt dgoulet wrote this file :). Even if this was "copied" from anothe=
r
> test
> plan the majority of the test plan was written/contributed by you.
> Your name and email should be there.
>
Ok

>
> > +#
> > +# This library is free software; you can redistribute it and/or modify
> it under
> > +# the terms of the GNU Lesser General Public License as published by
> the Free
> > +# Software Foundation; version 2.1 of the License.
> > +#
> > +# This library is distributed in the hope that it will be useful, but
> WITHOUT
> > +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY o=
r
> FITNESS
> > +# FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License
> for more
> > +# details.
> > +#
> > +# You should have received a copy of the GNU Lesser General Public
> License
> > +# along with this library; if not, write to the Free Software
> Foundation, Inc.,
> > +# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
> > +
> > +TEST_DESC=3D"Load session(s)"
>
> Should reflect the overall test: "Auto load session(s)"
>
OK

>
> > +
> > +CURDIR=3D$(dirname $0)/
> > +CONFIG_DIR=3D"${CURDIR}/configuration"
> > +TESTDIR=3D$CURDIR/../../../
> > +SESSIOND_BIN=3D"lttng-sessiond"
> > +RELAYD_BIN=3D"lttng-relayd"
> > +LTTNG_BIN=3D"lttng"
> > +export LTTNG_SESSION_CONFIG_XSD_PATH=3D$(readlink -m
> ${TESTDIR}../src/common/config/)
> > +
> > +DIR=3D$(readlink -f $TESTDIR)
> > +
> > +NUM_TESTS=3D10
> > +
> > +source $TESTDIR/utils/utils.sh
> > +
> > +# MUST set TESTDIR before calling those functions
> > +plan_tests $NUM_TESTS
> > +
> > +print_test_banner "$TEST_DESC"
> > +
> > +function test_auto_load_file()
> > +{
> > +     diag "Test auto load file"
> > +
> > +     stop_lttng_sessiond
>
> The stop_lttng_sessiond should be moved at the end of each sub test.
>
Ok, but I need one stop_lttng_session before the test, since it can't be
any lttng_sessiond
running when starting the tests.

>
> > +     export LTTNG_HOME=3D
> > +
> > +     start_lttng_sessiond $CURDIR/load-42.lttng
> > +     list_lttng_with_opts load-42
>
> Put stop_lttng_sessiond here.
>
> > +}
> > +
> > +function test_auto_load_dir()
> > +{
> > +     diag "Test auto load directory"
> > +
> > +     stop_lttng_sessiond
> > +
> > +     export LTTNG_HOME=3D
> > +     export LTTNG_DIR=3D/tmp/lttng_home
>
> Use "mktemp -d" here.
>
OK

>
> > +     mkdir -p $LTTNG_DIR
> > +     cp -f $CURDIR/load-42.lttng $LTTNG_DIR/
> > +
> > +     start_lttng_sessiond $LTTNG_DIR
> > +     list_lttng_with_opts load-42
> > +
> > +     rm -rf $LTTNG_DIR
> > +}
> > +
> > +function test_auto_load_lttng_home()
> > +{
> > +     diag "Test auto load by setting LTTNG_HOME"
> > +
> > +     stop_lttng_sessiond
> > +
> > +     export LTTNG_HOME=3D/tmp/lttng_home
>
> Use "mktemp -d" here.
>
OK

>
> > +     mkdir -p $LTTNG_HOME/.lttng/sessions/auto
> > +     cp -f $CURDIR/load-42.lttng $LTTNG_HOME/.lttng/sessions/auto
> > +
> > +     start_lttng_sessiond
> > +     list_lttng_with_opts load-42
> > +
> > +     rm -rf $LTTNG_HOME/.lttng/sessions/auto
>
> Make sure to remove the complete LTTNG_HOME directory.
>
OK

>
> > +}
> > +
> > +TESTS=3D(
> > +     test_auto_load_file
> > +     test_auto_load_dir
> > +     test_auto_load_lttng_home
> > +)
> > +
> > +for fct_test in ${TESTS[@]};
> > +do
> > +     TRACE_PATH=3D$(mktemp -d)
> > +
> > +     ${fct_test}
> > +     if [ $? -ne 0 ]; then
> > +             break;
> > +     fi
> > +     # Only delete if successful
> > +     rm -rf $TRACE_PATH
> > +done
> > +
> > +stop_lttng_sessiond
>
> Remove this.
>
OK

>
> > --
> > 2.17.0
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--00000000000045c5cc056c30ab34
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,=C2=A0<div><br></div><div>I will update the patch and r=
esend it tomorrow</div><div><br></div><div>Regards</div><div>Anders<br><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr">m=C3=A5n 14 maj 2018 kl 18:17 s=
krev Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jonathan.rajotte-julien@=
efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt;:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">Hi Anders<br>
<br>
Thanks for proposing this patch.<br>
<br>
We will need more context here. Are those currently failing and exposing a<=
br>
problem?<br></blockquote><div>Yes, lttng-tools 2.10.4 is broken when having=
 auto-load sessions, see<br><a href=3D"https://lists.lttng.org/pipermail/lt=
tng-dev/2018-May/028014.html">https://lists.lttng.org/pipermail/lttng-dev/2=
018-May/028014.html</a></div><div><br>I will add a longer commit message=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
<br>
See comments inline.<br>
<br>
<br>
On Mon, May 14, 2018 at 05:30:53PM +0200, Anders Wallin wrote:<br>
&gt; Signed-off-by: Anders Wallin &lt;<a href=3D"mailto:wallinux@gmail.com"=
 target=3D"_blank">wallinux@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/fast_regression=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 .../regression/tools/save-load/test_autoload=C2=A0 | 101 +++++++=
+++++++++++<br>
&gt;=C2=A0 2 files changed, 102 insertions(+)<br>
&gt;=C2=A0 create mode 100755 tests/regression/tools/save-load/test_autoloa=
d<br>
&gt; <br>
&gt; diff --git a/tests/fast_regression b/tests/fast_regression<br>
&gt; index bbce068f..2f02f872 100644<br>
&gt; --- a/tests/fast_regression<br>
&gt; +++ b/tests/fast_regression<br>
&gt; @@ -13,6 +13,7 @@ regression/tools/snapshots/test_ust_fast<br>
&gt;=C2=A0 regression/tools/snapshots/test_ust_streaming<br>
&gt;=C2=A0 regression/tools/save-load/test_save<br>
&gt;=C2=A0 regression/tools/save-load/test_load<br>
&gt; +regression/tools/save-load/test_autoload<br>
&gt;=C2=A0 regression/tools/mi/test_mi<br>
&gt;=C2=A0 regression/tools/wildcard/test_event_wildcard<br>
&gt;=C2=A0 regression/tools/crash/test_crash<br>
&gt; diff --git a/tests/regression/tools/save-load/test_autoload b/tests/re=
gression/tools/save-load/test_autoload<br>
&gt; new file mode 100755<br>
&gt; index 00000000..ea1210de<br>
&gt; --- /dev/null<br>
&gt; +++ b/tests/regression/tools/save-load/test_autoload<br>
&gt; @@ -0,0 +1,101 @@<br>
&gt; +#!/bin/bash<br>
&gt; +#<br>
&gt; +# Copyright (C) - 2014 David Goulet &lt;<a href=3D"mailto:dgoulet@eff=
icios.com" target=3D"_blank">dgoulet@efficios.com</a>&gt;<br>
<br>
I doubt dgoulet wrote this file :). Even if this was &quot;copied&quot; fro=
m another test<br>
plan the majority of the test plan was written/contributed by you.<br>
Your name and email should be there.<br></blockquote><div>Ok=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
<br>
&gt; +#<br>
&gt; +# This library is free software; you can redistribute it and/or modif=
y it under<br>
&gt; +# the terms of the GNU Lesser General Public License as published by =
the Free<br>
&gt; +# Software Foundation; version 2.1 of the License.<br>
&gt; +#<br>
&gt; +# This library is distributed in the hope that it will be useful, but=
 WITHOUT<br>
&gt; +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or FITNESS<br>
&gt; +# FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License=
 for more<br>
&gt; +# details.<br>
&gt; +#<br>
&gt; +# You should have received a copy of the GNU Lesser General Public Li=
cense<br>
&gt; +# along with this library; if not, write to the Free Software Foundat=
ion, Inc.,<br>
&gt; +# 51 Franklin Street, Fifth Floor, Boston, MA=C2=A0 02110-1301 USA<br=
>
&gt; +<br>
&gt; +TEST_DESC=3D&quot;Load session(s)&quot;<br>
<br>
Should reflect the overall test: &quot;Auto load session(s)&quot;<br></bloc=
kquote><div>OK=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; +<br>
&gt; +CURDIR=3D$(dirname $0)/<br>
&gt; +CONFIG_DIR=3D&quot;${CURDIR}/configuration&quot;<br>
&gt; +TESTDIR=3D$CURDIR/../../../<br>
&gt; +SESSIOND_BIN=3D&quot;lttng-sessiond&quot;<br>
&gt; +RELAYD_BIN=3D&quot;lttng-relayd&quot;<br>
&gt; +LTTNG_BIN=3D&quot;lttng&quot;<br>
&gt; +export LTTNG_SESSION_CONFIG_XSD_PATH=3D$(readlink -m ${TESTDIR}../src=
/common/config/)<br>
&gt; +<br>
&gt; +DIR=3D$(readlink -f $TESTDIR)<br>
&gt; +<br>
&gt; +NUM_TESTS=3D10<br>
&gt; +<br>
&gt; +source $TESTDIR/utils/utils.sh<br>
&gt; +<br>
&gt; +# MUST set TESTDIR before calling those functions<br>
&gt; +plan_tests $NUM_TESTS<br>
&gt; +<br>
&gt; +print_test_banner &quot;$TEST_DESC&quot;<br>
&gt; +<br>
&gt; +function test_auto_load_file()<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0diag &quot;Test auto load file&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0stop_lttng_sessiond<br>
<br>
The stop_lttng_sessiond should be moved at the end of each sub test.<br></b=
lockquote><div>Ok, but I need one stop_lttng_session before the test, since=
 it can&#39;t be any lttng_sessiond=C2=A0</div><div>running when starting t=
he tests.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0export LTTNG_HOME=3D<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0start_lttng_sessiond $CURDIR/load-42.lttng<br>
&gt; +=C2=A0 =C2=A0 =C2=A0list_lttng_with_opts load-42<br>
<br>
Put stop_lttng_sessiond here.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +function test_auto_load_dir()<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0diag &quot;Test auto load directory&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0stop_lttng_sessiond<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0export LTTNG_HOME=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0export LTTNG_DIR=3D/tmp/lttng_home<br>
<br>
Use &quot;mktemp -d&quot; here.<br></blockquote><div>OK=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mkdir -p $LTTNG_DIR<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cp -f $CURDIR/load-42.lttng $LTTNG_DIR/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0start_lttng_sessiond $LTTNG_DIR<br>
&gt; +=C2=A0 =C2=A0 =C2=A0list_lttng_with_opts load-42<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rm -rf $LTTNG_DIR<br>
&gt; +}<br>
&gt; +<br>
&gt; +function test_auto_load_lttng_home()<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0diag &quot;Test auto load by setting LTTNG_HOME&q=
uot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0stop_lttng_sessiond<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0export LTTNG_HOME=3D/tmp/lttng_home<br>
<br>
Use &quot;mktemp -d&quot; here.<br></blockquote><div>OK=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mkdir -p $LTTNG_HOME/.lttng/sessions/auto<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cp -f $CURDIR/load-42.lttng $LTTNG_HOME/.lttng/se=
ssions/auto<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0start_lttng_sessiond<br>
&gt; +=C2=A0 =C2=A0 =C2=A0list_lttng_with_opts load-42<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rm -rf $LTTNG_HOME/.lttng/sessions/auto<br>
<br>
Make sure to remove the complete LTTNG_HOME directory.<br></blockquote><div=
>OK=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; +}<br>
&gt; +<br>
&gt; +TESTS=3D(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0test_auto_load_file<br>
&gt; +=C2=A0 =C2=A0 =C2=A0test_auto_load_dir<br>
&gt; +=C2=A0 =C2=A0 =C2=A0test_auto_load_lttng_home<br>
&gt; +)<br>
&gt; +<br>
&gt; +for fct_test in ${TESTS[@]};<br>
&gt; +do<br>
&gt; +=C2=A0 =C2=A0 =C2=A0TRACE_PATH=3D$(mktemp -d)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0${fct_test}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0fi<br>
&gt; +=C2=A0 =C2=A0 =C2=A0# Only delete if successful<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rm -rf $TRACE_PATH<br>
&gt; +done<br>
&gt; +<br>
&gt; +stop_lttng_sessiond<br>
<br>
Remove this.<br></blockquote><div>OK=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
<br>
&gt; -- <br>
&gt; 2.17.0<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div></div></div>

--00000000000045c5cc056c30ab34--

--===============7596256971950290081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7596256971950290081==--
