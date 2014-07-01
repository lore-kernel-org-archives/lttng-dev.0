From: "Brosseau, Yannick" <yannick.brosseau@gmail.com>
Subject: Fwd: [Bug 1114691] New: lttng-ust do not build on
	ppc64le archi
Date: Tue, 1 Jul 2014 12:24:55 -0400
Message-ID: <CAEzWAeKKrQ5d7_esDkbxSbbCQ0x13ogh9JMkxikdwVyppCWEvQ__13881.0265380473$1404231962$gmane$org@mail.gmail.com>
References: <bug-1114691-315593@bugzilla.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1925172344=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <yannick.brosseau@gmail.com>) id 1X20rd-0006W2-CF
 for lttng-dev@lists.lttng.org; Tue, 01 Jul 2014 12:25:08 -0400
Received: by mail-qg0-f53.google.com with SMTP id i50so3514706qgf.40
 for <lttng-dev@lists.lttng.org>; Tue, 01 Jul 2014 09:24:55 -0700 (PDT)
In-Reply-To: <bug-1114691-315593@bugzilla.redhat.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1925172344==
Content-Type: multipart/alternative; boundary=001a11c2ca4a55f0e904fd24375e

--001a11c2ca4a55f0e904fd24375e
Content-Type: text/plain; charset=UTF-8

We are not white listing powerpc64le in ust build. The following bug report
have a patch for it.

---------- Forwarded message ----------
From: <bugzilla@redhat.com>
Date: Mon, Jun 30, 2014 at 12:36 PM
Subject: [Bug 1114691] New: lttng-ust do not build on ppc64le archi
To: yannick.brosseau@gmail.com


https://bugzilla.redhat.com/show_bug.cgi?id=1114691

            Bug ID: 1114691
           Summary: lttng-ust do not build on ppc64le archi
           Product: Fedora
           Version: rawhide
         Component: lttng-ust
          Severity: medium
          Assignee: yannick.brosseau@gmail.com
          Reporter: normand@linux.vnet.ibm.com
        QA Contact: extras-qa@fedoraproject.org
                CC: suchakra@gmail.com, yannick.brosseau@gmail.com



Created attachment 913481
  --> https://bugzilla.redhat.com/attachment.cgi?id=913481&action=edit
lttng-ust-ppc64le_update_configure_ac.patch

Description of problem: lttng-ust do not build on ppc64le archi


Version-Release number of selected component (if applicable):
lttng-ust-2.4.1-2.fc21

Steps to Reproduce:
1. fedpkg clone -a lttng-ust
2. fedpkg mockbuild

Actual results:
http://ppc.koji.fedoraproject.org/koji/taskinfo?taskID=1913658
===
checking host system alignment requirements... configure: error: unable to
detect alignment requirements (unsupported architecture (powerpc64le)?)
===


Additional info:
with following spec change and attached patch the scratch build at taskid
===
diff --git a/lttng-ust.spec b/lttng-ust.spec
index 5abbef1..0951250 100644
--- a/lttng-ust.spec
+++ b/lttng-ust.spec
@@ -7,6 +7,8 @@ Summary:        LTTng Userspace Tracer library
 URL:            http://lttng.org/ust/
 Source0:        http://lttng.org/files/lttng-ust/%{name}-%{version}.tar.bz2

+Patch1:                lttng-ust-ppc64le_update_configure_ac.patch
+
 BuildRequires:  libuuid-devel texinfo systemtap-sdt-devel libtool
 BuildRequires:  userspace-rcu-devel >= 0.7.2

@@ -26,6 +28,7 @@ LTTng userspace tracing

 %prep
 %setup -q
+%patch1 -p1

 %build
 %ifarch s390 s390x
@@ -33,6 +36,10 @@ LTTng userspace tracing
 %global optflags %(echo %{optflags} | sed 's/-O2/-O1/')
 %endif

+%ifarch ppc64le
+# as long as patch1 not yet upstream to generate configure
+autoreconf -iv
+%endif
 #Reinitialize libtool with the fedora version to remove Rpath
 libtoolize -cvfi
 %configure --docdir=%{_docdir}/%{name} --disable-static --with-sdt
===

--
You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.

--001a11c2ca4a55f0e904fd24375e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">We are not white listing powerpc64le in ust build. The fol=
lowing bug report have a patch for it.=C2=A0<br><br><div class=3D"gmail_quo=
te">---------- Forwarded message ----------<br>From: <b class=3D"gmail_send=
ername"></b> <span dir=3D"ltr">&lt;<a href=3D"mailto:bugzilla@redhat.com">b=
ugzilla@redhat.com</a>&gt;</span><br>
Date: Mon, Jun 30, 2014 at 12:36 PM<br>Subject: [Bug 1114691] New: lttng-us=
t do not build on ppc64le archi<br>To: <a href=3D"mailto:yannick.brosseau@g=
mail.com">yannick.brosseau@gmail.com</a><br><br><br><a href=3D"https://bugz=
illa.redhat.com/show_bug.cgi?id=3D1114691" target=3D"_blank">https://bugzil=
la.redhat.com/show_bug.cgi?id=3D1114691</a><br>

<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Bug ID: 1114691<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Summary: lttng-ust do not build on=
 ppc64le archi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Product: Fedora<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Version: rawhide<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Component: lttng-ust<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Severity: medium<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Assignee: <a href=3D"mailto:yannick.bros=
seau@gmail.com">yannick.brosseau@gmail.com</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Reporter: <a href=3D"mailto:normand@linu=
x.vnet.ibm.com">normand@linux.vnet.ibm.com</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 QA Contact: <a href=3D"mailto:extras-qa@fedorap=
roject.org">extras-qa@fedoraproject.org</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CC: <a href=3D"mail=
to:suchakra@gmail.com">suchakra@gmail.com</a>, <a href=3D"mailto:yannick.br=
osseau@gmail.com">yannick.brosseau@gmail.com</a><br>
<br>
<br>
<br>
Created attachment 913481<br>
=C2=A0 --&gt; <a href=3D"https://bugzilla.redhat.com/attachment.cgi?id=3D91=
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
@@ -7,6 +7,8 @@ Summary: =C2=A0 =C2=A0 =C2=A0 =C2=A0LTTng Userspace Tracer =
library<br>
=C2=A0URL: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://lttng=
.org/ust/" target=3D"_blank">http://lttng.org/ust/</a><br>
=C2=A0Source0: =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://lttng.org/files=
/lttng-ust/%{name}-%{version}.tar.bz2" target=3D"_blank">http://lttng.org/f=
iles/lttng-ust/%{name}-%{version}.tar.bz2</a><br>
<br>
+Patch1: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lttng-ust-p=
pc64le_update_configure_ac.patch<br>
+<br>
=C2=A0BuildRequires: =C2=A0libuuid-devel texinfo systemtap-sdt-devel libtoo=
l<br>
=C2=A0BuildRequires: =C2=A0userspace-rcu-devel &gt;=3D 0.7.2<br>
<br>
@@ -26,6 +28,7 @@ LTTng userspace tracing<br>
<br>
=C2=A0%prep<br>
=C2=A0%setup -q<br>
+%patch1 -p1<br>
<br>
=C2=A0%build<br>
=C2=A0%ifarch s390 s390x<br>
@@ -33,6 +36,10 @@ LTTng userspace tracing<br>
=C2=A0%global optflags %(echo %{optflags} | sed &#39;s/-O2/-O1/&#39;)<br>
=C2=A0%endif<br>
<br>
+%ifarch ppc64le<br>
+# as long as patch1 not yet upstream to generate configure<br>
+autoreconf -iv<br>
+%endif<br>
=C2=A0#Reinitialize libtool with the fedora version to remove Rpath<br>
=C2=A0libtoolize -cvfi<br>
=C2=A0%configure --docdir=3D%{_docdir}/%{name} --disable-static --with-sdt<=
br>
=3D=3D=3D<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
You are receiving this mail because:<br>
You are on the CC list for the bug.<br>
You are the assignee for the bug.<br>
</font></span></div><br></div>

--001a11c2ca4a55f0e904fd24375e--


--===============1925172344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1925172344==--
