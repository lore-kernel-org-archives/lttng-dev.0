From: Nan Xiao <xiaonan830818@gmail.com>
Subject: Fwd:  Install kmod-lttng-modules error on CentOS 7
Date: Thu, 28 May 2015 09:43:57 +0800
Message-ID: <CA+MhoaP0P3jicWGLPbjMpRyPdkG7g0YCqMSk5nYP9vyN=_1JUQ__27486.1485501335$1432777557$gmane$org@mail.gmail.com>
References: <CA+MhoaPNB3hqU0QWG3qxo9WjsmJ0DgfK1X88WMUwsN8wX=5C+Q@mail.gmail.com>
 <CA+jJMxuYqG18z0KWiZ9AaFmTs9jRfkvw=X3KfLSaLGtbecF8zQ@mail.gmail.com>
 <CA+MhoaNbPdAT3ZoEqH+TftM6O9PaaqwCAY_vgsmM+kd10a8DHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0397594258=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <xiaonan830818@gmail.com>) id 1Yxmrb-0007fu-Dt
 for lttng-dev@lists.lttng.org; Wed, 27 May 2015 21:44:14 -0400
Received: by wicmx19 with SMTP id mx19so129955512wic.0
 for <lttng-dev@lists.lttng.org>; Wed, 27 May 2015 18:43:57 -0700 (PDT)
In-Reply-To: <CA+MhoaNbPdAT3ZoEqH+TftM6O9PaaqwCAY_vgsmM+kd10a8DHw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0397594258==
Content-Type: multipart/alternative; boundary=001a1137f4d83910f105171a7ed4

--001a1137f4d83910f105171a7ed4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Best Regards
Nan Xiao

---------- Forwarded message ----------
From: Nan Xiao <xiaonan830818@gmail.com>
Date: Thu, May 28, 2015 at 9:42 AM
Subject: Re: [lttng-dev] Install kmod-lttng-modules error on CentOS 7
To: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com>


After trying with SRPM, it reports the same error:

In file included from
/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrumentat=
ion/events/lttng-module/../../../probes/define_trace.h:139:0,
                 from
/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrumentat=
ion/events/lttng-module/kvm.h:381,
                 from
/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-probe-kvm=
.c:42:
/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrumentat=
ion/events/lttng-module/../../../probes/lttng-events.h:151:6:
error: conflicting types for 'trace_kvm_async_pf_completed'
 void trace_##_name(_proto);
      ^
/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrumentat=
ion/events/lttng-module/../../../probes/lttng-events.h:47:2:
note: in expansion of macro 'DEFINE_EVENT_MAP'
  DEFINE_EVENT_MAP(map, name, map, PARAMS(proto), PARAMS(args))
  ^
/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrumentat=
ion/events/lttng-module/../../../probes/lttng-events.h:89:2:
note: in expansion of macro 'TRACE_EVENT_MAP'
  TRACE_EVENT_MAP(name, name,    \
  ^
/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrumentat=
ion/events/lttng-module/../../../probes/../instrumentation/events/lttng-mod=
ule/kvm.h:351:1:
note: in expansion of macro 'TRACE_EVENT'
 TRACE_EVENT(
 ^
In file included from include/linux/module.h:18:0,
                 from
/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-probe-kvm=
.c:23:
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
[/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-probe-kv=
m.o]
Error 1
make[1]: *** [/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes]
Error 2
make: *** [_module_/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default]
Error 2
make: Leaving directory `/usr/src/kernels/3.10.0-229.4.2.el7.x86_64'
error: Bad exit status from /var/tmp/rpm-tmp.BYJgqS (%build)


RPM build errors:
    Bad exit status from /var/tmp/rpm-tmp.BYJgqS (%build)


Could you help to fix it and provide patch for CentOS? Thanks!

Best Regards
Nan Xiao

On Wed, May 27, 2015 at 11:09 PM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> CentOS might be using a different kernel (not binary compatible). Have yo=
u
> tried installing from the source RPM [1]?
>
> $ wget
> http://packages.efficios.com/rhel/7/SRPMS/latest/lttng-modules/lttng-modu=
les-2.5.0-1.el7.src.rpm
> $ rpm -i lttng-modules-2.5.0-1.el7.src.rpm
> $ cd ~/rpmbuild/SPECS
> $ rpmbuild -bb lttng-modules.spec
>
> Trying this here on a RHEL7 machine seems to fail since the latest kernel
> update (3.10.0-229.4.2.el7.x86_64) with:
>
> In file included from
> /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../inst=
rumentation/events/lttng-module/../../../probes/define_trace.h:139:0,
>                  from
> /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../inst=
rumentation/events/lttng-module/kvm.h:381,
>                  from
> /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-p=
robe-kvm.c:42:
> /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../inst=
rumentation/events/lttng-module/../../../probes/lttng-events.h:151:6:
> error: conflicting types for 'trace_kvm_async_pf_completed'
>  void trace_##_name(_proto);
>       ^
> /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../inst=
rumentation/events/lttng-module/../../../probes/lttng-events.h:47:2:
> note: in expansion of macro 'DEFINE_EVENT_MAP'
>   DEFINE_EVENT_MAP(map, name, map, PARAMS(proto), PARAMS(args))
>   ^
> /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../inst=
rumentation/events/lttng-module/../../../probes/lttng-events.h:89:2:
> note: in expansion of macro 'TRACE_EVENT_MAP'
>   TRACE_EVENT_MAP(name, name,    \
>   ^
> /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../inst=
rumentation/events/lttng-module/../../../probes/../instrumentation/events/l=
ttng-module/kvm.h:351:1:
> note: in expansion of macro 'TRACE_EVENT'
>  TRACE_EVENT(
>  ^
> In file included from include/linux/module.h:18:0,
>                  from
> /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-p=
robe-kvm.c:23:
> include/linux/tracepoint.h:162:21: note: previous definition of
> 'trace_kvm_async_pf_completed' was here
>   static inline void trace_##name(proto)    \
>                      ^
> include/linux/tracepoint.h:259:3: note: in expansion of macro
> '__DECLARE_TRACE'
>    __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1, \
>    ^
> include/linux/tracepoint.h:391:2: note: in expansion of macro
> 'DECLARE_TRACE'
>   DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
>   ^
> include/trace/events/kvm.h:317:1: note: in expansion of macro 'TRACE_EVEN=
T'
>  TRACE_EVENT(
>  ^
> make[2]: ***
> [/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-=
probe-kvm.o]
> Error 1
> make[1]: ***
> [/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes] Error=
 2
> make: ***
> [_module_/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default] Erro=
r 2
> make: Leaving directory `/usr/src/kernels/3.10.0-229.4.2.el7.x86_64'
> error: Bad exit status from /var/tmp/rpm-tmp.75xMIN (%build)
>
> I guess this is caused by a patch backported to Red Hat's 3.10 kernel.
> I'll investigate and see what can be done.
>
> Regards,
> J=C3=A9r=C3=A9mie
>
> [1]
> http://packages.efficios.com/rhel/7/SRPMS/latest/lttng-modules/lttng-modu=
les-2.5.0-1.el7.src.rpm
>
> On Wed, May 27, 2015 at 5:40 AM, Nan Xiao <xiaonan830818@gmail.com> wrote=
:
>
>> Hi all,
>>
>> I am following this page (http://packages.efficios.com/) , and try to
>> install lttng on CentOS 7. All the modules are installed OK,
>> except kmod-lttng-modules, and the error info likes this:
>>
>> [root@mawent3 ~]# yum install kmod-lttng-modules
>> Loaded plugins: fastestmirror
>> Loading mirror speeds from cached hostfile
>>  * base: centos.mirrors.tds.net
>>  * extras: bay.uchicago.edu
>>  * updates: dallas.tx.mirror.xygenhosting.com
>> Resolving Dependencies
>> --> Running transaction check
>> ---> Package kmod-lttng-modules.x86_64 0:2.5.0-1.el7 will be installed
>> --> Processing Dependency: kernel(__alloc_pages_nodemask) =3D 0xfb29f2e9
>> for package: kmod-lttng-modules-2.5.0-1.el7.x86_64
>> --> Processing Dependency: kernel(node_data) =3D 0xc0ebbdec for package:
>> kmod-lttng-modules-2.5.0-1.el7.x86_64
>> --> Finished Dependency Resolution
>> Error: Package: kmod-lttng-modules-2.5.0-1.el7.x86_64
>> (EfficiOS-RHEL7-x86-64)
>>            Requires: kernel(node_data) =3D 0xc0ebbdec
>>            Installed: kernel-3.10.0-229.el7.x86_64 (@anaconda)
>>                kernel(node_data) =3D 0x3142b10b
>>            Installed: kernel-3.10.0-229.4.2.el7.x86_64 (@updates)
>>                kernel(node_data) =3D 0x3142b10b
>>            Available: kernel-3.10.0-229.1.2.el7.x86_64 (updates)
>>                kernel(node_data) =3D 0x3142b10b
>>            Available: kernel-debug-3.10.0-229.el7.x86_64 (base)
>>                kernel(node_data) =3D 0x7881b78f
>>            Available: kernel-debug-3.10.0-229.1.2.el7.x86_64 (updates)
>>                kernel(node_data) =3D 0x7881b78f
>>            Available: kernel-debug-3.10.0-229.4.2.el7.x86_64 (updates)
>>                kernel(node_data) =3D 0x7881b78f
>> Error: Package: kmod-lttng-modules-2.5.0-1.el7.x86_64
>> (EfficiOS-RHEL7-x86-64)
>>            Requires: kernel(__alloc_pages_nodemask) =3D 0xfb29f2e9
>>            Installed: kernel-3.10.0-229.el7.x86_64 (@anaconda)
>>                kernel(__alloc_pages_nodemask) =3D 0x8616cca3
>>            Installed: kernel-3.10.0-229.4.2.el7.x86_64 (@updates)
>>                kernel(__alloc_pages_nodemask) =3D 0x8616cca3
>>            Available: kernel-3.10.0-229.1.2.el7.x86_64 (updates)
>>                kernel(__alloc_pages_nodemask) =3D 0x8616cca3
>>            Available: kernel-debug-3.10.0-229.el7.x86_64 (base)
>>                kernel(__alloc_pages_nodemask) =3D 0xcc655c2a
>>            Available: kernel-debug-3.10.0-229.1.2.el7.x86_64 (updates)
>>                kernel(__alloc_pages_nodemask) =3D 0xcc655c2a
>>            Available: kernel-debug-3.10.0-229.4.2.el7.x86_64 (updates)
>>                kernel(__alloc_pages_nodemask) =3D 0xcc655c2a
>>  You could try using --skip-broken to work around the problem
>>  You could try running: rpm -Va --nofiles --nodigest
>>
>>
>> Could someone give help on this issue? Thanks very much in advance!
>>
>> Best Regards
>> Nan Xiao
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--001a1137f4d83910f105171a7ed4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br clear=3D"all"><div><div class=3D"gmail_signature"><div=
 dir=3D"ltr">Best Regards<div>Nan Xiao</div></div></div></div>
<br><div class=3D"gmail_quote">---------- Forwarded message ----------<br>F=
rom: <b class=3D"gmail_sendername">Nan Xiao</b> <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:xiaonan830818@gmail.com">xiaonan830818@gmail.com</a>&gt;</span=
><br>Date: Thu, May 28, 2015 at 9:42 AM<br>Subject: Re: [lttng-dev] Install=
 kmod-lttng-modules error on CentOS 7<br>To: J=C3=A9r=C3=A9mie Galarneau &l=
t;<a href=3D"mailto:jeremie.galarneau@efficios.com">jeremie.galarneau@effic=
ios.com</a>&gt;<br><br><br><div dir=3D"ltr">After trying with SRPM, it repo=
rts the same error: =C2=A0=C2=A0<div><br></div><div><div>In file included f=
rom /root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrume=
ntation/events/lttng-module/../../../probes/define_trace.h:139:0,</div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /root/r=
pmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrumentation/eve=
nts/lttng-module/kvm.h:381,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from /root/rpmbuild/BUILD/lttng-modules-2.5.0/ob=
j/default/probes/lttng-probe-kvm.c:42:</div><div>/root/rpmbuild/BUILD/lttng=
-modules-2.5.0/obj/default/probes/../instrumentation/events/lttng-module/..=
/../../probes/lttng-events.h:151:6: error: conflicting types for &#39;trace=
_kvm_async_pf_completed&#39;</div><div>=C2=A0void trace_##_name(_proto);</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 ^</div><div>/root/rpmbuild/BUILD/lttng-modules=
-2.5.0/obj/default/probes/../instrumentation/events/lttng-module/../../../p=
robes/lttng-events.h:47:2: note: in expansion of macro &#39;DEFINE_EVENT_MA=
P&#39;</div><span class=3D""><div>=C2=A0 DEFINE_EVENT_MAP(map, name, map, P=
ARAMS(proto), PARAMS(args))</div><div>=C2=A0 ^</div></span><div>/root/rpmbu=
ild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrumentation/events/=
lttng-module/../../../probes/lttng-events.h:89:2: note: in expansion of mac=
ro &#39;TRACE_EVENT_MAP&#39;</div><div>=C2=A0 TRACE_EVENT_MAP(name, name, =
=C2=A0 =C2=A0\</div><div>=C2=A0 ^</div><div>/root/rpmbuild/BUILD/lttng-modu=
les-2.5.0/obj/default/probes/../instrumentation/events/lttng-module/../../.=
./probes/../instrumentation/events/lttng-module/kvm.h:351:1: note: in expan=
sion of macro &#39;TRACE_EVENT&#39;</div><span class=3D""><div>=C2=A0TRACE_=
EVENT(</div><div>=C2=A0^</div><div>In file included from include/linux/modu=
le.h:18:0,</div></span><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from /root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/=
probes/lttng-probe-kvm.c:23:</div><span class=3D""><div>include/linux/trace=
point.h:162:21: note: previous definition of &#39;trace_kvm_async_pf_comple=
ted&#39; was here</div><div>=C2=A0 static inline void trace_##name(proto) =
=C2=A0 =C2=A0\</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0^</div><div>include/linux/tracepoint.h:259:3: no=
te: in expansion of macro &#39;__DECLARE_TRACE&#39;</div><div>=C2=A0 =C2=A0=
__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1, \</div><div>=C2=A0 =
=C2=A0^</div><div>include/linux/tracepoint.h:391:2: note: in expansion of m=
acro &#39;DECLARE_TRACE&#39;</div><div>=C2=A0 DECLARE_TRACE(name, PARAMS(pr=
oto), PARAMS(args))</div><div>=C2=A0 ^</div><div>include/trace/events/kvm.h=
:317:1: note: in expansion of macro &#39;TRACE_EVENT&#39;</div><div>=C2=A0T=
RACE_EVENT(</div><div>=C2=A0^</div></span><div>make[2]: *** [/root/rpmbuild=
/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-probe-kvm.o] Error 1</d=
iv><div>make[1]: *** [/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/=
probes] Error 2</div><div>make: *** [_module_/root/rpmbuild/BUILD/lttng-mod=
ules-2.5.0/obj/default] Error 2</div><div>make: Leaving directory `/usr/src=
/kernels/3.10.0-229.4.2.el7.x86_64&#39;</div><div>error: Bad exit status fr=
om /var/tmp/rpm-tmp.BYJgqS (%build)</div><div><br></div><div><br></div><div=
>RPM build errors:</div><div>=C2=A0 =C2=A0 Bad exit status from /var/tmp/rp=
m-tmp.BYJgqS (%build)</div></div><div><br></div><div><br></div><div>Could y=
ou help to fix it and provide patch for CentOS? Thanks!</div></div><div cla=
ss=3D"gmail_extra"><br clear=3D"all"><div><div><div dir=3D"ltr">Best Regard=
s<span class=3D"HOEnZb"><font color=3D"#888888"><div>Nan Xiao</div></font><=
/span></div></div></div><div><div class=3D"h5">
<br><div class=3D"gmail_quote">On Wed, May 27, 2015 at 11:09 PM, J=C3=A9r=
=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarne=
au@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">CentOS migh=
t be using a different kernel (not binary compatible). Have you tried insta=
lling from the source RPM [1]?<div><br></div><div>$ wget=C2=A0<a href=3D"ht=
tp://packages.efficios.com/rhel/7/SRPMS/latest/lttng-modules/lttng-modules-=
2.5.0-1.el7.src.rpm" target=3D"_blank">http://packages.efficios.com/rhel/7/=
SRPMS/latest/lttng-modules/lttng-modules-2.5.0-1.el7.src.rpm</a></div><div>=
$ rpm -i lttng-modules-2.5.0-1.el7.src.rpm</div><div>$ cd ~/rpmbuild/SPECS<=
/div><div>$ rpmbuild -bb lttng-modules.spec</div><div><br></div><div>Trying=
 this here on a RHEL7 machine seems to fail since the latest kernel update =
(3.10.0-229.4.2.el7.x86_64) with:</div><div><br></div><div><div>In file inc=
luded from /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probe=
s/../instrumentation/events/lttng-module/../../../probes/define_trace.h:139=
:0,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/.=
./instrumentation/events/lttng-module/kvm.h:381,</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /home/build/rpmbuild/B=
UILD/lttng-modules-2.5.0/obj/default/probes/lttng-probe-kvm.c:42:</div><div=
>/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instr=
umentation/events/lttng-module/../../../probes/lttng-events.h:151:6: error:=
 conflicting types for &#39;trace_kvm_async_pf_completed&#39;</div><div>=C2=
=A0void trace_##_name(_proto);</div><div>=C2=A0 =C2=A0 =C2=A0 ^</div><div>/=
home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrum=
entation/events/lttng-module/../../../probes/lttng-events.h:47:2: note: in =
expansion of macro &#39;DEFINE_EVENT_MAP&#39;</div><div>=C2=A0 DEFINE_EVENT=
_MAP(map, name, map, PARAMS(proto), PARAMS(args))</div><div>=C2=A0 ^</div><=
div>/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../in=
strumentation/events/lttng-module/../../../probes/lttng-events.h:89:2: note=
: in expansion of macro &#39;TRACE_EVENT_MAP&#39;</div><div>=C2=A0 TRACE_EV=
ENT_MAP(name, name, =C2=A0 =C2=A0\</div><div>=C2=A0 ^</div><div>/home/build=
/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrumentation/e=
vents/lttng-module/../../../probes/../instrumentation/events/lttng-module/k=
vm.h:351:1: note: in expansion of macro &#39;TRACE_EVENT&#39;</div><div>=C2=
=A0TRACE_EVENT(</div><div>=C2=A0^</div><div>In file included from include/l=
inux/module.h:18:0,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/de=
fault/probes/lttng-probe-kvm.c:23:</div><div>include/linux/tracepoint.h:162=
:21: note: previous definition of &#39;trace_kvm_async_pf_completed&#39; wa=
s here</div><div>=C2=A0 static inline void trace_##name(proto) =C2=A0 =C2=
=A0\</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0^</div><div>include/linux/tracepoint.h:259:3: note: in exp=
ansion of macro &#39;__DECLARE_TRACE&#39;</div><div>=C2=A0 =C2=A0__DECLARE_=
TRACE(name, PARAMS(proto), PARAMS(args), 1, \</div><div>=C2=A0 =C2=A0^</div=
><div>include/linux/tracepoint.h:391:2: note: in expansion of macro &#39;DE=
CLARE_TRACE&#39;</div><div>=C2=A0 DECLARE_TRACE(name, PARAMS(proto), PARAMS=
(args))</div><div>=C2=A0 ^</div><div>include/trace/events/kvm.h:317:1: note=
: in expansion of macro &#39;TRACE_EVENT&#39;</div><div>=C2=A0TRACE_EVENT(<=
/div><div>=C2=A0^</div><div>make[2]: *** [/home/build/rpmbuild/BUILD/lttng-=
modules-2.5.0/obj/default/probes/lttng-probe-kvm.o] Error 1</div><div>make[=
1]: *** [/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes]=
 Error 2</div><div>make: *** [_module_/home/build/rpmbuild/BUILD/lttng-modu=
les-2.5.0/obj/default] Error 2</div><div>make: Leaving directory `/usr/src/=
kernels/3.10.0-229.4.2.el7.x86_64&#39;</div><div>error: Bad exit status fro=
m /var/tmp/rpm-tmp.75xMIN (%build)</div></div><div><br></div><div>I guess t=
his is caused by a patch backported to Red Hat&#39;s 3.10 kernel. I&#39;ll =
investigate and see what can be done.</div><div><br></div><div>Regards,</di=
v><div>J=C3=A9r=C3=A9mie</div><div><br></div><div>[1]=C2=A0<a href=3D"http:=
//packages.efficios.com/rhel/7/SRPMS/latest/lttng-modules/lttng-modules-2.5=
.0-1.el7.src.rpm" target=3D"_blank">http://packages.efficios.com/rhel/7/SRP=
MS/latest/lttng-modules/lttng-modules-2.5.0-1.el7.src.rpm</a></div></div><d=
iv class=3D"gmail_extra"><br><div class=3D"gmail_quote"><div><div>On Wed, M=
ay 27, 2015 at 5:40 AM, Nan Xiao <span dir=3D"ltr">&lt;<a href=3D"mailto:xi=
aonan830818@gmail.com" target=3D"_blank">xiaonan830818@gmail.com</a>&gt;</s=
pan> wrote:<br></div></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div><div di=
r=3D"ltr">Hi all,<div><br></div><div>I am following this page (<a href=3D"h=
ttp://packages.efficios.com/" target=3D"_blank">http://packages.efficios.co=
m/</a>) , and try to install lttng on CentOS 7. All the modules are install=
ed OK, except=C2=A0kmod-lttng-modules, and the error info likes this: =C2=
=A0</div><div><br></div><div><div>[root@mawent3 ~]# yum install kmod-lttng-=
modules</div><div>Loaded plugins: fastestmirror</div><div>Loading mirror sp=
eeds from cached hostfile</div><div>=C2=A0* base: <a href=3D"http://centos.=
mirrors.tds.net" target=3D"_blank">centos.mirrors.tds.net</a></div><div>=C2=
=A0* extras: <a href=3D"http://bay.uchicago.edu" target=3D"_blank">bay.uchi=
cago.edu</a></div><div>=C2=A0* updates: <a href=3D"http://dallas.tx.mirror.=
xygenhosting.com" target=3D"_blank">dallas.tx.mirror.xygenhosting.com</a></=
div><div>Resolving Dependencies</div><div>--&gt; Running transaction check<=
/div><div>---&gt; Package kmod-lttng-modules.x86_64 0:2.5.0-1.el7 will be i=
nstalled</div><div>--&gt; Processing Dependency: kernel(__alloc_pages_nodem=
ask) =3D 0xfb29f2e9 for package: kmod-lttng-modules-2.5.0-1.el7.x86_64</div=
><div>--&gt; Processing Dependency: kernel(node_data) =3D 0xc0ebbdec for pa=
ckage: kmod-lttng-modules-2.5.0-1.el7.x86_64</div><div>--&gt; Finished Depe=
ndency Resolution</div><div>Error: Package: kmod-lttng-modules-2.5.0-1.el7.=
x86_64 (EfficiOS-RHEL7-x86-64)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0Requires: kernel(node_data) =3D 0xc0ebbdec</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Installed: kernel-3.10.0-229.el7.x86_64 (@anacon=
da)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel=
(node_data) =3D 0x3142b10b</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Installed: kernel-3.10.0-229.4.2.el7.x86_64 (@updates)</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(node_data) =3D 0x314=
2b10b</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Available: kernel-=
3.10.0-229.1.2.el7.x86_64 (updates)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(node_data) =3D 0x3142b10b</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Available: kernel-debug-3.10.0-229.el=
7.x86_64 (base)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0kernel(node_data) =3D 0x7881b78f</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Available: kernel-debug-3.10.0-229.1.2.el7.x86_64 (updates=
)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(n=
ode_data) =3D 0x7881b78f</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Available: kernel-debug-3.10.0-229.4.2.el7.x86_64 (updates)</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(node_data) =
=3D 0x7881b78f</div><div>Error: Package: kmod-lttng-modules-2.5.0-1.el7.x86=
_64 (EfficiOS-RHEL7-x86-64)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Requires: kernel(__alloc_pages_nodemask) =3D 0xfb29f2e9</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Installed: kernel-3.10.0-229.el7.x86_=
64 (@anaconda)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0kernel(__alloc_pages_nodemask) =3D 0x8616cca3</div><div>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0Installed: kernel-3.10.0-229.4.2.el7.x86_64 (@u=
pdates)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ke=
rnel(__alloc_pages_nodemask) =3D 0x8616cca3</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Available: kernel-3.10.0-229.1.2.el7.x86_64 (updates)</=
div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(__al=
loc_pages_nodemask) =3D 0x8616cca3</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0Available: kernel-debug-3.10.0-229.el7.x86_64 (base)</div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(__alloc_page=
s_nodemask) =3D 0xcc655c2a</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Available: kernel-debug-3.10.0-229.1.2.el7.x86_64 (updates)</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(__alloc_pages=
_nodemask) =3D 0xcc655c2a</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Available: kernel-debug-3.10.0-229.4.2.el7.x86_64 (updates)</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(__alloc_pages=
_nodemask) =3D 0xcc655c2a</div><div>=C2=A0You could try using --skip-broken=
 to work around the problem</div><div>=C2=A0You could try running: rpm -Va =
--nofiles --nodigest</div><div><br></div><div><br></div><div>Could someone =
give help on this issue? Thanks very much in advance!</div><div><br></div><=
div><div><div dir=3D"ltr">Best Regards<span><font color=3D"#888888"><div>Na=
n Xiao</div></font></span></div></div></div>
</div></div>
<br></div></div>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><span><font color=3D"#888888"><br><br clear=3D"all">=
<div><br></div>-- <br><div>J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br>=
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a></div>
</font></span></div>
</blockquote></div><br></div></div></div>
</div><br></div>

--001a1137f4d83910f105171a7ed4--


--===============0397594258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0397594258==--
