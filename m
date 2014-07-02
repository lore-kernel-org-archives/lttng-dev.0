From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Fwd: [Bug 1114691] New: lttng-ust do not build
	on	ppc64le archi
Date: Wed, 2 Jul 2014 14:34:19 +0000 (UTC)
Message-ID: <694568026.7120.1404311659977.JavaMail.zimbra__37500.6445371129$1404311730$gmane$org@efficios.com>
References: <bug-1114691-315593@bugzilla.redhat.com>
 <CAEzWAeKKrQ5d7_esDkbxSbbCQ0x13ogh9JMkxikdwVyppCWEvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1569628084=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1X2Lc6-0005vF-Cx
 for lttng-dev@lists.lttng.org; Wed, 02 Jul 2014 10:34:28 -0400
In-Reply-To: <CAEzWAeKKrQ5d7_esDkbxSbbCQ0x13ogh9JMkxikdwVyppCWEvQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1569628084==
Content-Type: multipart/alternative;
	boundary="----=_Part_7119_629963048.1404311659975"

------=_Part_7119_629963048.1404311659975
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Merged into master, thanks! 

Mathieu 

----- Original Message -----

> From: "Yannick Brosseau" <yannick.brosseau@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Tuesday, July 1, 2014 12:24:55 PM
> Subject: [lttng-dev] Fwd: [Bug 1114691] New: lttng-ust do not build on
> ppc64le archi

> We are not white listing powerpc64le in ust build. The following bug report
> have a patch for it.

> ---------- Forwarded message ----------
> From: < bugzilla@redhat.com >
> Date: Mon, Jun 30, 2014 at 12:36 PM
> Subject: [Bug 1114691] New: lttng-ust do not build on ppc64le archi
> To: yannick.brosseau@gmail.com

> https://bugzilla.redhat.com/show_bug.cgi?id=1114691

> Bug ID: 1114691
> Summary: lttng-ust do not build on ppc64le archi
> Product: Fedora
> Version: rawhide
> Component: lttng-ust
> Severity: medium
> Assignee: yannick.brosseau@gmail.com
> Reporter: normand@linux.vnet.ibm.com
> QA Contact: extras-qa@fedoraproject.org
> CC: suchakra@gmail.com , yannick.brosseau@gmail.com

> Created attachment 913481
> --> https://bugzilla.redhat.com/attachment.cgi?id=913481&action=edit
> lttng-ust-ppc64le_update_configure_ac.patch

> Description of problem: lttng-ust do not build on ppc64le archi

> Version-Release number of selected component (if applicable):
> lttng-ust-2.4.1-2.fc21

> Steps to Reproduce:
> 1. fedpkg clone -a lttng-ust
> 2. fedpkg mockbuild

> Actual results:
> http://ppc.koji.fedoraproject.org/koji/taskinfo?taskID=1913658
> ===
> checking host system alignment requirements... configure: error: unable to
> detect alignment requirements (unsupported architecture (powerpc64le)?)
> ===

> Additional info:
> with following spec change and attached patch the scratch build at taskid
> ===
> diff --git a/lttng-ust.spec b/lttng-ust.spec
> index 5abbef1..0951250 100644
> --- a/lttng-ust.spec
> +++ b/lttng-ust.spec
> @@ -7,6 +7,8 @@ Summary: LTTng Userspace Tracer library
> URL: http://lttng.org/ust/
> Source0: http://lttng.org/files/lttng-ust/%{name}-%{version}.tar.bz2

> +Patch1: lttng-ust-ppc64le_update_configure_ac.patch
> +
> BuildRequires: libuuid-devel texinfo systemtap-sdt-devel libtool
> BuildRequires: userspace-rcu-devel >= 0.7.2

> @@ -26,6 +28,7 @@ LTTng userspace tracing

> %prep
> %setup -q
> +%patch1 -p1

> %build
> %ifarch s390 s390x
> @@ -33,6 +36,10 @@ LTTng userspace tracing
> %global optflags %(echo %{optflags} | sed 's/-O2/-O1/')
> %endif

> +%ifarch ppc64le
> +# as long as patch1 not yet upstream to generate configure
> +autoreconf -iv
> +%endif
> #Reinitialize libtool with the fedora version to remove Rpath
> libtoolize -cvfi
> %configure --docdir=%{_docdir}/%{name} --disable-static --with-sdt
> ===

> --
> You are receiving this mail because:
> You are on the CC list for the bug.
> You are the assignee for the bug.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_7119_629963048.1404311659975
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>Merged into master, thanks!<br><=
/div><div><br></div><div>Mathieu<br></div><div><br></div><div><br></div><hr=
 id=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;margin-lef=
t:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text=
-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><b=
>From: </b>"Yannick Brosseau" &lt;yannick.brosseau@gmail.com&gt;<br><b>To: =
</b>lttng-dev@lists.lttng.org<br><b>Sent: </b>Tuesday, July 1, 2014 12:24:5=
5 PM<br><b>Subject: </b>[lttng-dev] Fwd: [Bug 1114691] New: lttng-ust do no=
t build on&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ppc64le archi<br>=
<div><br></div><div dir=3D"ltr">We are not white listing powerpc64le in ust=
 build. The following bug report have a patch for it.&nbsp;<br><div><br></d=
iv><div class=3D"gmail_quote">---------- Forwarded message ----------<br>Fr=
om: <b class=3D"gmail_sendername"></b> <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:bugzilla@redhat.com" target=3D"_blank">bugzilla@redhat.com</a>&gt;</spa=
n><br>
Date: Mon, Jun 30, 2014 at 12:36 PM<br>Subject: [Bug 1114691] New: lttng-us=
t do not build on ppc64le archi<br>To: <a href=3D"mailto:yannick.brosseau@g=
mail.com" target=3D"_blank">yannick.brosseau@gmail.com</a><br><div><br></di=
v><br><a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1114691" tar=
get=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi?id=3D1114691</a><br=
>

<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Bug ID: 1114691<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Summary: lttng-ust do not build on=
 ppc64le archi<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Product: Fedora<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Version: rawhide<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Component: lttng-ust<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Severity: medium<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Assignee: <a href=3D"mailto:yannick.bros=
seau@gmail.com" target=3D"_blank">yannick.brosseau@gmail.com</a><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Reporter: <a href=3D"mailto:normand@linu=
x.vnet.ibm.com" target=3D"_blank">normand@linux.vnet.ibm.com</a><br>
&nbsp; &nbsp; &nbsp; &nbsp; QA Contact: <a href=3D"mailto:extras-qa@fedorap=
roject.org" target=3D"_blank">extras-qa@fedoraproject.org</a><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; CC: <a href=3D"mail=
to:suchakra@gmail.com" target=3D"_blank">suchakra@gmail.com</a>, <a href=3D=
"mailto:yannick.brosseau@gmail.com" target=3D"_blank">yannick.brosseau@gmai=
l.com</a><br>
<br>
<br>
<br>
Created attachment 913481<br>
&nbsp; --&gt; <a href=3D"https://bugzilla.redhat.com/attachment.cgi?id=3D91=
3481&amp;action=3Dedit
lttng-ust-ppc64le_update_configure_ac.patch" target=3D"_blank">https://bugz=
illa.redhat.com/attachment.cgi?id=3D913481&amp;action=3Dedit<br>
lttng-ust-ppc64le_update_configure_ac.patch</a><br>
<br>
Description of problem: lttng-ust do not build on ppc64le archi<br>
<br>
<br>
Version-Release number of selected component (if applicable):<br>
lttng-ust-2.4.1-2.fc21<br>
<br>
Steps to Reproduce:<br>
1. fedpkg clone -a lttng-ust<br>
2. fedpkg mockbuild<br>
<br>
Actual results:<br>
<a href=3D"http://ppc.koji.fedoraproject.org/koji/taskinfo?taskID=3D1913658=
" target=3D"_blank">http://ppc.koji.fedoraproject.org/koji/taskinfo?taskID=
=3D1913658</a><br>
=3D=3D=3D<br>
checking host system alignment requirements... configure: error: unable to<=
br>
detect alignment requirements (unsupported architecture (powerpc64le)?)<br>
=3D=3D=3D<br>
<br>
<br>
Additional info:<br>
with following spec change and attached patch the scratch build at taskid<b=
r>
=3D=3D=3D<br>
diff --git a/lttng-ust.spec b/lttng-ust.spec<br>
index 5abbef1..0951250 100644<br>
--- a/lttng-ust.spec<br>
+++ b/lttng-ust.spec<br>
@@ -7,6 +7,8 @@ Summary: &nbsp; &nbsp; &nbsp; &nbsp;LTTng Userspace Tracer =
library<br>
&nbsp;URL: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<a href=3D"http://lttng=
.org/ust/" target=3D"_blank">http://lttng.org/ust/</a><br>
&nbsp;Source0: &nbsp; &nbsp; &nbsp; &nbsp;<a href=3D"http://lttng.org/files=
/lttng-ust/%{name}-%{version}.tar.bz2" target=3D"_blank">http://lttng.org/f=
iles/lttng-ust/%{name}-%{version}.tar.bz2</a><br>
<br>
+Patch1: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lttng-ust-p=
pc64le_update_configure_ac.patch<br>
+<br>
&nbsp;BuildRequires: &nbsp;libuuid-devel texinfo systemtap-sdt-devel libtoo=
l<br>
&nbsp;BuildRequires: &nbsp;userspace-rcu-devel &gt;=3D 0.7.2<br>
<br>
@@ -26,6 +28,7 @@ LTTng userspace tracing<br>
<br>
&nbsp;%prep<br>
&nbsp;%setup -q<br>
+%patch1 -p1<br>
<br>
&nbsp;%build<br>
&nbsp;%ifarch s390 s390x<br>
@@ -33,6 +36,10 @@ LTTng userspace tracing<br>
&nbsp;%global optflags %(echo %{optflags} | sed 's/-O2/-O1/')<br>
&nbsp;%endif<br>
<br>
+%ifarch ppc64le<br>
+# as long as patch1 not yet upstream to generate configure<br>
+autoreconf -iv<br>
+%endif<br>
&nbsp;#Reinitialize libtool with the fedora version to remove Rpath<br>
&nbsp;libtoolize -cvfi<br>
&nbsp;%configure --docdir=3D%{_docdir}/%{name} --disable-static --with-sdt<=
br>
=3D=3D=3D<br>
<span class=3D"HOEnZb"><span style=3D"color: #888888;" data-mce-style=3D"co=
lor: #888888;" color=3D"#888888"><br>
--<br>
You are receiving this mail because:<br>
You are on the CC list for the bug.<br>
You are the assignee for the bug.<br>
</span></span></div><br></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev<br></blockquote><div><br><br></div><div><br></div><div>--=
 <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<=
br>http://www.efficios.com<span name=3D"x"></span><br></div></div></body></=
html>
------=_Part_7119_629963048.1404311659975--


--===============1569628084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1569628084==--
