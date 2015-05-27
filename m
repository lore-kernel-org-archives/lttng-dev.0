From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Install kmod-lttng-modules error on CentOS 7
Date: Wed, 27 May 2015 11:09:54 -0400
Message-ID: <CA+jJMxuYqG18z0KWiZ9AaFmTs9jRfkvw=X3KfLSaLGtbecF8zQ__47454.2850781747$1432739476$gmane$org@mail.gmail.com>
References: <CA+MhoaPNB3hqU0QWG3qxo9WjsmJ0DgfK1X88WMUwsN8wX=5C+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1671529023=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Yxcxz-0004Zl-Lu
 for lttng-dev@lists.lttng.org; Wed, 27 May 2015 11:10:03 -0400
Received: by qchk10 with SMTP id k10so5071220qch.2
 for <lttng-dev@lists.lttng.org>; Wed, 27 May 2015 08:09:54 -0700 (PDT)
In-Reply-To: <CA+MhoaPNB3hqU0QWG3qxo9WjsmJ0DgfK1X88WMUwsN8wX=5C+Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Nan Xiao <xiaonan830818@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1671529023==
Content-Type: multipart/alternative; boundary=001a113ea656a469fc051711a2cc

--001a113ea656a469fc051711a2cc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

CentOS might be using a different kernel (not binary compatible). Have you
tried installing from the source RPM [1]?

$ wget
http://packages.efficios.com/rhel/7/SRPMS/latest/lttng-modules/lttng-module=
s-2.5.0-1.el7.src.rpm
$ rpm -i lttng-modules-2.5.0-1.el7.src.rpm
$ cd ~/rpmbuild/SPECS
$ rpmbuild -bb lttng-modules.spec

Trying this here on a RHEL7 machine seems to fail since the latest kernel
update (3.10.0-229.4.2.el7.x86_64) with:

In file included from
/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instru=
mentation/events/lttng-module/../../../probes/define_trace.h:139:0,
                 from
/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instru=
mentation/events/lttng-module/kvm.h:381,
                 from
/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-pro=
be-kvm.c:42:
/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instru=
mentation/events/lttng-module/../../../probes/lttng-events.h:151:6:
error: conflicting types for 'trace_kvm_async_pf_completed'
 void trace_##_name(_proto);
      ^
/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instru=
mentation/events/lttng-module/../../../probes/lttng-events.h:47:2:
note: in expansion of macro 'DEFINE_EVENT_MAP'
  DEFINE_EVENT_MAP(map, name, map, PARAMS(proto), PARAMS(args))
  ^
/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instru=
mentation/events/lttng-module/../../../probes/lttng-events.h:89:2:
note: in expansion of macro 'TRACE_EVENT_MAP'
  TRACE_EVENT_MAP(name, name,    \
  ^
/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instru=
mentation/events/lttng-module/../../../probes/../instrumentation/events/ltt=
ng-module/kvm.h:351:1:
note: in expansion of macro 'TRACE_EVENT'
 TRACE_EVENT(
 ^
In file included from include/linux/module.h:18:0,
                 from
/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-pro=
be-kvm.c:23:
include/linux/tracepoint.h:162:21: note: previous definition of
'trace_kvm_async_pf_completed' was here
  static inline void trace_##name(proto)    \
                     ^
include/linux/tracepoint.h:259:3: note: in expansion of macro
'__DECLARE_TRACE'
   __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1, \
   ^
include/linux/tracepoint.h:391:2: note: in expansion of macro
'DECLARE_TRACE'
  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
  ^
include/trace/events/kvm.h:317:1: note: in expansion of macro 'TRACE_EVENT'
 TRACE_EVENT(
 ^
make[2]: ***
[/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-pr=
obe-kvm.o]
Error 1
make[1]: ***
[/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes] Error 2
make: ***
[_module_/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default] Error =
2
make: Leaving directory `/usr/src/kernels/3.10.0-229.4.2.el7.x86_64'
error: Bad exit status from /var/tmp/rpm-tmp.75xMIN (%build)

I guess this is caused by a patch backported to Red Hat's 3.10 kernel. I'll
investigate and see what can be done.

Regards,
J=C3=A9r=C3=A9mie

[1]
http://packages.efficios.com/rhel/7/SRPMS/latest/lttng-modules/lttng-module=
s-2.5.0-1.el7.src.rpm

On Wed, May 27, 2015 at 5:40 AM, Nan Xiao <xiaonan830818@gmail.com> wrote:

> Hi all,
>
> I am following this page (http://packages.efficios.com/) , and try to
> install lttng on CentOS 7. All the modules are installed OK,
> except kmod-lttng-modules, and the error info likes this:
>
> [root@mawent3 ~]# yum install kmod-lttng-modules
> Loaded plugins: fastestmirror
> Loading mirror speeds from cached hostfile
>  * base: centos.mirrors.tds.net
>  * extras: bay.uchicago.edu
>  * updates: dallas.tx.mirror.xygenhosting.com
> Resolving Dependencies
> --> Running transaction check
> ---> Package kmod-lttng-modules.x86_64 0:2.5.0-1.el7 will be installed
> --> Processing Dependency: kernel(__alloc_pages_nodemask) =3D 0xfb29f2e9 =
for
> package: kmod-lttng-modules-2.5.0-1.el7.x86_64
> --> Processing Dependency: kernel(node_data) =3D 0xc0ebbdec for package:
> kmod-lttng-modules-2.5.0-1.el7.x86_64
> --> Finished Dependency Resolution
> Error: Package: kmod-lttng-modules-2.5.0-1.el7.x86_64
> (EfficiOS-RHEL7-x86-64)
>            Requires: kernel(node_data) =3D 0xc0ebbdec
>            Installed: kernel-3.10.0-229.el7.x86_64 (@anaconda)
>                kernel(node_data) =3D 0x3142b10b
>            Installed: kernel-3.10.0-229.4.2.el7.x86_64 (@updates)
>                kernel(node_data) =3D 0x3142b10b
>            Available: kernel-3.10.0-229.1.2.el7.x86_64 (updates)
>                kernel(node_data) =3D 0x3142b10b
>            Available: kernel-debug-3.10.0-229.el7.x86_64 (base)
>                kernel(node_data) =3D 0x7881b78f
>            Available: kernel-debug-3.10.0-229.1.2.el7.x86_64 (updates)
>                kernel(node_data) =3D 0x7881b78f
>            Available: kernel-debug-3.10.0-229.4.2.el7.x86_64 (updates)
>                kernel(node_data) =3D 0x7881b78f
> Error: Package: kmod-lttng-modules-2.5.0-1.el7.x86_64
> (EfficiOS-RHEL7-x86-64)
>            Requires: kernel(__alloc_pages_nodemask) =3D 0xfb29f2e9
>            Installed: kernel-3.10.0-229.el7.x86_64 (@anaconda)
>                kernel(__alloc_pages_nodemask) =3D 0x8616cca3
>            Installed: kernel-3.10.0-229.4.2.el7.x86_64 (@updates)
>                kernel(__alloc_pages_nodemask) =3D 0x8616cca3
>            Available: kernel-3.10.0-229.1.2.el7.x86_64 (updates)
>                kernel(__alloc_pages_nodemask) =3D 0x8616cca3
>            Available: kernel-debug-3.10.0-229.el7.x86_64 (base)
>                kernel(__alloc_pages_nodemask) =3D 0xcc655c2a
>            Available: kernel-debug-3.10.0-229.1.2.el7.x86_64 (updates)
>                kernel(__alloc_pages_nodemask) =3D 0xcc655c2a
>            Available: kernel-debug-3.10.0-229.4.2.el7.x86_64 (updates)
>                kernel(__alloc_pages_nodemask) =3D 0xcc655c2a
>  You could try using --skip-broken to work around the problem
>  You could try running: rpm -Va --nofiles --nodigest
>
>
> Could someone give help on this issue? Thanks very much in advance!
>
> Best Regards
> Nan Xiao
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a113ea656a469fc051711a2cc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">CentOS might be using a different kernel (not binary compa=
tible). Have you tried installing from the source RPM [1]?<div><br></div><d=
iv>$ wget=C2=A0<a href=3D"http://packages.efficios.com/rhel/7/SRPMS/latest/=
lttng-modules/lttng-modules-2.5.0-1.el7.src.rpm">http://packages.efficios.c=
om/rhel/7/SRPMS/latest/lttng-modules/lttng-modules-2.5.0-1.el7.src.rpm</a><=
/div><div>$ rpm -i lttng-modules-2.5.0-1.el7.src.rpm</div><div>$ cd ~/rpmbu=
ild/SPECS</div><div>$ rpmbuild -bb lttng-modules.spec</div><div><br></div><=
div>Trying this here on a RHEL7 machine seems to fail since the latest kern=
el update (3.10.0-229.4.2.el7.x86_64) with:</div><div><br></div><div><div>I=
n file included from /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/def=
ault/probes/../instrumentation/events/lttng-module/../../../probes/define_t=
race.h:139:0,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/defaul=
t/probes/../instrumentation/events/lttng-module/kvm.h:381,</div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /home/build/rp=
mbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-probe-kvm.c:42:</=
div><div>/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/=
../instrumentation/events/lttng-module/../../../probes/lttng-events.h:151:6=
: error: conflicting types for &#39;trace_kvm_async_pf_completed&#39;</div>=
<div>=C2=A0void trace_##_name(_proto);</div><div>=C2=A0 =C2=A0 =C2=A0 ^</di=
v><div>/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/..=
/instrumentation/events/lttng-module/../../../probes/lttng-events.h:47:2: n=
ote: in expansion of macro &#39;DEFINE_EVENT_MAP&#39;</div><div>=C2=A0 DEFI=
NE_EVENT_MAP(map, name, map, PARAMS(proto), PARAMS(args))</div><div>=C2=A0 =
^</div><div>/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/prob=
es/../instrumentation/events/lttng-module/../../../probes/lttng-events.h:89=
:2: note: in expansion of macro &#39;TRACE_EVENT_MAP&#39;</div><div>=C2=A0 =
TRACE_EVENT_MAP(name, name, =C2=A0 =C2=A0\</div><div>=C2=A0 ^</div><div>/ho=
me/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrumen=
tation/events/lttng-module/../../../probes/../instrumentation/events/lttng-=
module/kvm.h:351:1: note: in expansion of macro &#39;TRACE_EVENT&#39;</div>=
<div>=C2=A0TRACE_EVENT(</div><div>=C2=A0^</div><div>In file included from i=
nclude/linux/module.h:18:0,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from /home/build/rpmbuild/BUILD/lttng-modules-2.=
5.0/obj/default/probes/lttng-probe-kvm.c:23:</div><div>include/linux/tracep=
oint.h:162:21: note: previous definition of &#39;trace_kvm_async_pf_complet=
ed&#39; was here</div><div>=C2=A0 static inline void trace_##name(proto) =
=C2=A0 =C2=A0\</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0^</div><div>include/linux/tracepoint.h:259:3: no=
te: in expansion of macro &#39;__DECLARE_TRACE&#39;</div><div>=C2=A0 =C2=A0=
__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1, \</div><div>=C2=A0 =
=C2=A0^</div><div>include/linux/tracepoint.h:391:2: note: in expansion of m=
acro &#39;DECLARE_TRACE&#39;</div><div>=C2=A0 DECLARE_TRACE(name, PARAMS(pr=
oto), PARAMS(args))</div><div>=C2=A0 ^</div><div>include/trace/events/kvm.h=
:317:1: note: in expansion of macro &#39;TRACE_EVENT&#39;</div><div>=C2=A0T=
RACE_EVENT(</div><div>=C2=A0^</div><div>make[2]: *** [/home/build/rpmbuild/=
BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-probe-kvm.o] Error 1</di=
v><div>make[1]: *** [/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/def=
ault/probes] Error 2</div><div>make: *** [_module_/home/build/rpmbuild/BUIL=
D/lttng-modules-2.5.0/obj/default] Error 2</div><div>make: Leaving director=
y `/usr/src/kernels/3.10.0-229.4.2.el7.x86_64&#39;</div><div>error: Bad exi=
t status from /var/tmp/rpm-tmp.75xMIN (%build)</div></div><div><br></div><d=
iv>I guess this is caused by a patch backported to Red Hat&#39;s 3.10 kerne=
l. I&#39;ll investigate and see what can be done.</div><div><br></div><div>=
Regards,</div><div>J=C3=A9r=C3=A9mie</div><div><br></div><div>[1]=C2=A0<a h=
ref=3D"http://packages.efficios.com/rhel/7/SRPMS/latest/lttng-modules/lttng=
-modules-2.5.0-1.el7.src.rpm">http://packages.efficios.com/rhel/7/SRPMS/lat=
est/lttng-modules/lttng-modules-2.5.0-1.el7.src.rpm</a></div></div><div cla=
ss=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, May 27, 2015 at 5=
:40 AM, Nan Xiao <span dir=3D"ltr">&lt;<a href=3D"mailto:xiaonan830818@gmai=
l.com" target=3D"_blank">xiaonan830818@gmail.com</a>&gt;</span> wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi all,<div><br></div><div>I=
 am following this page (<a href=3D"http://packages.efficios.com/" target=
=3D"_blank">http://packages.efficios.com/</a>) , and try to install lttng o=
n CentOS 7. All the modules are installed OK, except=C2=A0kmod-lttng-module=
s, and the error info likes this: =C2=A0</div><div><br></div><div><div>[roo=
t@mawent3 ~]# yum install kmod-lttng-modules</div><div>Loaded plugins: fast=
estmirror</div><div>Loading mirror speeds from cached hostfile</div><div>=
=C2=A0* base: <a href=3D"http://centos.mirrors.tds.net" target=3D"_blank">c=
entos.mirrors.tds.net</a></div><div>=C2=A0* extras: <a href=3D"http://bay.u=
chicago.edu" target=3D"_blank">bay.uchicago.edu</a></div><div>=C2=A0* updat=
es: <a href=3D"http://dallas.tx.mirror.xygenhosting.com" target=3D"_blank">=
dallas.tx.mirror.xygenhosting.com</a></div><div>Resolving Dependencies</div=
><div>--&gt; Running transaction check</div><div>---&gt; Package kmod-lttng=
-modules.x86_64 0:2.5.0-1.el7 will be installed</div><div>--&gt; Processing=
 Dependency: kernel(__alloc_pages_nodemask) =3D 0xfb29f2e9 for package: kmo=
d-lttng-modules-2.5.0-1.el7.x86_64</div><div>--&gt; Processing Dependency: =
kernel(node_data) =3D 0xc0ebbdec for package: kmod-lttng-modules-2.5.0-1.el=
7.x86_64</div><div>--&gt; Finished Dependency Resolution</div><div>Error: P=
ackage: kmod-lttng-modules-2.5.0-1.el7.x86_64 (EfficiOS-RHEL7-x86-64)</div>=
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Requires: kernel(node_data) =
=3D 0xc0ebbdec</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Installed=
: kernel-3.10.0-229.el7.x86_64 (@anaconda)</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(node_data) =3D 0x3142b10b</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Installed: kernel-3.10.0-229.4.2=
.el7.x86_64 (@updates)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0kernel(node_data) =3D 0x3142b10b</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Available: kernel-3.10.0-229.1.2.el7.x86_64 (update=
s)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(=
node_data) =3D 0x3142b10b</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Available: kernel-debug-3.10.0-229.el7.x86_64 (base)</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(node_data) =3D 0x788=
1b78f</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Available: kernel-=
debug-3.10.0-229.1.2.el7.x86_64 (updates)</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(node_data) =3D 0x7881b78f</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Available: kernel-debug-3.10.0-2=
29.4.2.el7.x86_64 (updates)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0kernel(node_data) =3D 0x7881b78f</div><div>Error: Packa=
ge: kmod-lttng-modules-2.5.0-1.el7.x86_64 (EfficiOS-RHEL7-x86-64)</div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Requires: kernel(__alloc_pages_no=
demask) =3D 0xfb29f2e9</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I=
nstalled: kernel-3.10.0-229.el7.x86_64 (@anaconda)</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(__alloc_pages_nodemask) =3D=
 0x8616cca3</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Installed: k=
ernel-3.10.0-229.4.2.el7.x86_64 (@updates)</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(__alloc_pages_nodemask) =3D 0x8616=
cca3</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Available: kernel-3=
.10.0-229.1.2.el7.x86_64 (updates)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(__alloc_pages_nodemask) =3D 0x8616cca3</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Available: kernel-debug-3.=
10.0-229.el7.x86_64 (base)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0kernel(__alloc_pages_nodemask) =3D 0xcc655c2a</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Available: kernel-debug-3.10.0-229=
.1.2.el7.x86_64 (updates)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0kernel(__alloc_pages_nodemask) =3D 0xcc655c2a</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Available: kernel-debug-3.10.0-229=
.4.2.el7.x86_64 (updates)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0kernel(__alloc_pages_nodemask) =3D 0xcc655c2a</div><div>=
=C2=A0You could try using --skip-broken to work around the problem</div><di=
v>=C2=A0You could try running: rpm -Va --nofiles --nodigest</div><div><br><=
/div><div><br></div><div>Could someone give help on this issue? Thanks very=
 much in advance!</div><div><br></div><div><div><div dir=3D"ltr">Best Regar=
ds<span class=3D"HOEnZb"><font color=3D"#888888"><div>Nan Xiao</div></font>=
</span></div></div></div>
</div></div>
<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a h=
ref=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</=
a></div>
</div>

--001a113ea656a469fc051711a2cc--


--===============1671529023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1671529023==--
