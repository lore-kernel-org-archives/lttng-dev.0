From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Fwd: Install kmod-lttng-modules error on CentOS 7
Date: Thu, 28 May 2015 14:11:54 -0400
Message-ID: <CA+jJMxsg749A6MfXE1mEMiNnJMNWXo+VTuTg_b0A0+nnQwvZhg__15735.6942807839$1432836796$gmane$org@mail.gmail.com>
References: <CA+MhoaPNB3hqU0QWG3qxo9WjsmJ0DgfK1X88WMUwsN8wX=5C+Q@mail.gmail.com>
 <CA+jJMxuYqG18z0KWiZ9AaFmTs9jRfkvw=X3KfLSaLGtbecF8zQ@mail.gmail.com>
 <CA+MhoaNbPdAT3ZoEqH+TftM6O9PaaqwCAY_vgsmM+kd10a8DHw@mail.gmail.com>
 <CA+MhoaP0P3jicWGLPbjMpRyPdkG7g0YCqMSk5nYP9vyN=_1JUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0060355272=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Yy2Hg-0004HP-BT
 for lttng-dev@lists.lttng.org; Thu, 28 May 2015 14:12:05 -0400
Received: by qgf2 with SMTP id 2so20044271qgf.3
 for <lttng-dev@lists.lttng.org>; Thu, 28 May 2015 11:11:54 -0700 (PDT)
In-Reply-To: <CA+MhoaP0P3jicWGLPbjMpRyPdkG7g0YCqMSk5nYP9vyN=_1JUQ@mail.gmail.com>
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

--===============0060355272==
Content-Type: multipart/alternative; boundary=001a11359d106816ad0517284b27

--001a11359d106816ad0517284b27
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2015 at 9:43 PM, Nan Xiao <xiaonan830818@gmail.com> wrote:

>
> Best Regards
> Nan Xiao
>
> ---------- Forwarded message ----------
> From: Nan Xiao <xiaonan830818@gmail.com>
> Date: Thu, May 28, 2015 at 9:42 AM
> Subject: Re: [lttng-dev] Install kmod-lttng-modules error on CentOS 7
> To: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com>
>
>
> After trying with SRPM, it reports the same error:
>
> In file included from
> /root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrument=
ation/events/lttng-module/../../../probes/define_trace.h:139:0,
>                  from
> /root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrument=
ation/events/lttng-module/kvm.h:381,
>                  from
> /root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-probe-k=
vm.c:42:
> /root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrument=
ation/events/lttng-module/../../../probes/lttng-events.h:151:6:
> error: conflicting types for 'trace_kvm_async_pf_completed'
>  void trace_##_name(_proto);
>       ^
> /root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrument=
ation/events/lttng-module/../../../probes/lttng-events.h:47:2:
> note: in expansion of macro 'DEFINE_EVENT_MAP'
>   DEFINE_EVENT_MAP(map, name, map, PARAMS(proto), PARAMS(args))
>   ^
> /root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrument=
ation/events/lttng-module/../../../probes/lttng-events.h:89:2:
> note: in expansion of macro 'TRACE_EVENT_MAP'
>   TRACE_EVENT_MAP(name, name,    \
>   ^
> /root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrument=
ation/events/lttng-module/../../../probes/../instrumentation/events/lttng-m=
odule/kvm.h:351:1:
> note: in expansion of macro 'TRACE_EVENT'
>  TRACE_EVENT(
>  ^
> In file included from include/linux/module.h:18:0,
>                  from
> /root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-probe-k=
vm.c:23:
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
> [/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-probe-=
kvm.o]
> Error 1
> make[1]: *** [/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes=
]
> Error 2
> make: *** [_module_/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default]
> Error 2
> make: Leaving directory `/usr/src/kernels/3.10.0-229.4.2.el7.x86_64'
> error: Bad exit status from /var/tmp/rpm-tmp.BYJgqS (%build)
>
>
> RPM build errors:
>     Bad exit status from /var/tmp/rpm-tmp.BYJgqS (%build)
>
>
> Could you help to fix it and provide patch for CentOS? Thanks!
>

Hi Nan,

We have updated the packages on packages.efficios.com. The issue was caused
by patches backported by Red Hat to their 3.10 kernel as part of the
release of RHEL 7.1.

Can you check that the latest kmod-lttng-modules package on the repository
works?

The updated source RPM is also available at:
http://packages.efficios.com/rhel/7/SRPMS/latest/lttng-modules/lttng-module=
s-2.5.3-1.el7.src.rpm

The following patches, merged as part of lttng-modules' stable-2.5,
stable-2.6 and master branches add the necessary kernel version checks:

commit 51b961653d69b56528ae8c7e4cd39d140d75f610
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Wed May 27 12:56:05 2015 -0400

    Fix: RHEL 7.1 block instrumentation

    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit f30ae671364af1a69a5c5ad562e10a38c1bbaf2e
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Wed May 27 12:19:01 2015 -0400

    Fix: add RHEL version macros

    RHEL 7.1 has backported upstream patches that change the kvm.h
    tracepoint prototype. Add version check specific to RHEL to handle this
    case.

    RHEL 7.x has the required fixes backported that allow removing the 3.10
    blacklist check for them, so take this into account.

    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Regards,
J=C3=A9r=C3=A9mie


>
> Best Regards
> Nan Xiao
>
> On Wed, May 27, 2015 at 11:09 PM, J=C3=A9r=C3=A9mie Galarneau <
> jeremie.galarneau@efficios.com> wrote:
>
>> CentOS might be using a different kernel (not binary compatible). Have
>> you tried installing from the source RPM [1]?
>>
>> $ wget
>> http://packages.efficios.com/rhel/7/SRPMS/latest/lttng-modules/lttng-mod=
ules-2.5.0-1.el7.src.rpm
>> $ rpm -i lttng-modules-2.5.0-1.el7.src.rpm
>> $ cd ~/rpmbuild/SPECS
>> $ rpmbuild -bb lttng-modules.spec
>>
>> Trying this here on a RHEL7 machine seems to fail since the latest kerne=
l
>> update (3.10.0-229.4.2.el7.x86_64) with:
>>
>> In file included from
>> /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../ins=
trumentation/events/lttng-module/../../../probes/define_trace.h:139:0,
>>                  from
>> /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../ins=
trumentation/events/lttng-module/kvm.h:381,
>>                  from
>> /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-=
probe-kvm.c:42:
>> /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../ins=
trumentation/events/lttng-module/../../../probes/lttng-events.h:151:6:
>> error: conflicting types for 'trace_kvm_async_pf_completed'
>>  void trace_##_name(_proto);
>>       ^
>> /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../ins=
trumentation/events/lttng-module/../../../probes/lttng-events.h:47:2:
>> note: in expansion of macro 'DEFINE_EVENT_MAP'
>>   DEFINE_EVENT_MAP(map, name, map, PARAMS(proto), PARAMS(args))
>>   ^
>> /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../ins=
trumentation/events/lttng-module/../../../probes/lttng-events.h:89:2:
>> note: in expansion of macro 'TRACE_EVENT_MAP'
>>   TRACE_EVENT_MAP(name, name,    \
>>   ^
>> /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../ins=
trumentation/events/lttng-module/../../../probes/../instrumentation/events/=
lttng-module/kvm.h:351:1:
>> note: in expansion of macro 'TRACE_EVENT'
>>  TRACE_EVENT(
>>  ^
>> In file included from include/linux/module.h:18:0,
>>                  from
>> /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-=
probe-kvm.c:23:
>> include/linux/tracepoint.h:162:21: note: previous definition of
>> 'trace_kvm_async_pf_completed' was here
>>   static inline void trace_##name(proto)    \
>>                      ^
>> include/linux/tracepoint.h:259:3: note: in expansion of macro
>> '__DECLARE_TRACE'
>>    __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1, \
>>    ^
>> include/linux/tracepoint.h:391:2: note: in expansion of macro
>> 'DECLARE_TRACE'
>>   DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
>>   ^
>> include/trace/events/kvm.h:317:1: note: in expansion of macro
>> 'TRACE_EVENT'
>>  TRACE_EVENT(
>>  ^
>> make[2]: ***
>> [/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng=
-probe-kvm.o]
>> Error 1
>> make[1]: ***
>> [/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes] Erro=
r 2
>> make: ***
>> [_module_/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default] Err=
or 2
>> make: Leaving directory `/usr/src/kernels/3.10.0-229.4.2.el7.x86_64'
>> error: Bad exit status from /var/tmp/rpm-tmp.75xMIN (%build)
>>
>> I guess this is caused by a patch backported to Red Hat's 3.10 kernel.
>> I'll investigate and see what can be done.
>>
>> Regards,
>> J=C3=A9r=C3=A9mie
>>
>> [1]
>> http://packages.efficios.com/rhel/7/SRPMS/latest/lttng-modules/lttng-mod=
ules-2.5.0-1.el7.src.rpm
>>
>> On Wed, May 27, 2015 at 5:40 AM, Nan Xiao <xiaonan830818@gmail.com>
>> wrote:
>>
>>> Hi all,
>>>
>>> I am following this page (http://packages.efficios.com/) , and try to
>>> install lttng on CentOS 7. All the modules are installed OK,
>>> except kmod-lttng-modules, and the error info likes this:
>>>
>>> [root@mawent3 ~]# yum install kmod-lttng-modules
>>> Loaded plugins: fastestmirror
>>> Loading mirror speeds from cached hostfile
>>>  * base: centos.mirrors.tds.net
>>>  * extras: bay.uchicago.edu
>>>  * updates: dallas.tx.mirror.xygenhosting.com
>>> Resolving Dependencies
>>> --> Running transaction check
>>> ---> Package kmod-lttng-modules.x86_64 0:2.5.0-1.el7 will be installed
>>> --> Processing Dependency: kernel(__alloc_pages_nodemask) =3D 0xfb29f2e=
9
>>> for package: kmod-lttng-modules-2.5.0-1.el7.x86_64
>>> --> Processing Dependency: kernel(node_data) =3D 0xc0ebbdec for package=
:
>>> kmod-lttng-modules-2.5.0-1.el7.x86_64
>>> --> Finished Dependency Resolution
>>> Error: Package: kmod-lttng-modules-2.5.0-1.el7.x86_64
>>> (EfficiOS-RHEL7-x86-64)
>>>            Requires: kernel(node_data) =3D 0xc0ebbdec
>>>            Installed: kernel-3.10.0-229.el7.x86_64 (@anaconda)
>>>                kernel(node_data) =3D 0x3142b10b
>>>            Installed: kernel-3.10.0-229.4.2.el7.x86_64 (@updates)
>>>                kernel(node_data) =3D 0x3142b10b
>>>            Available: kernel-3.10.0-229.1.2.el7.x86_64 (updates)
>>>                kernel(node_data) =3D 0x3142b10b
>>>            Available: kernel-debug-3.10.0-229.el7.x86_64 (base)
>>>                kernel(node_data) =3D 0x7881b78f
>>>            Available: kernel-debug-3.10.0-229.1.2.el7.x86_64 (updates)
>>>                kernel(node_data) =3D 0x7881b78f
>>>            Available: kernel-debug-3.10.0-229.4.2.el7.x86_64 (updates)
>>>                kernel(node_data) =3D 0x7881b78f
>>> Error: Package: kmod-lttng-modules-2.5.0-1.el7.x86_64
>>> (EfficiOS-RHEL7-x86-64)
>>>            Requires: kernel(__alloc_pages_nodemask) =3D 0xfb29f2e9
>>>            Installed: kernel-3.10.0-229.el7.x86_64 (@anaconda)
>>>                kernel(__alloc_pages_nodemask) =3D 0x8616cca3
>>>            Installed: kernel-3.10.0-229.4.2.el7.x86_64 (@updates)
>>>                kernel(__alloc_pages_nodemask) =3D 0x8616cca3
>>>            Available: kernel-3.10.0-229.1.2.el7.x86_64 (updates)
>>>                kernel(__alloc_pages_nodemask) =3D 0x8616cca3
>>>            Available: kernel-debug-3.10.0-229.el7.x86_64 (base)
>>>                kernel(__alloc_pages_nodemask) =3D 0xcc655c2a
>>>            Available: kernel-debug-3.10.0-229.1.2.el7.x86_64 (updates)
>>>                kernel(__alloc_pages_nodemask) =3D 0xcc655c2a
>>>            Available: kernel-debug-3.10.0-229.4.2.el7.x86_64 (updates)
>>>                kernel(__alloc_pages_nodemask) =3D 0xcc655c2a
>>>  You could try using --skip-broken to work around the problem
>>>  You could try running: rpm -Va --nofiles --nodigest
>>>
>>>
>>> Could someone give help on this issue? Thanks very much in advance!
>>>
>>> Best Regards
>>> Nan Xiao
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>>
>>
>>
>> --
>> J=C3=A9r=C3=A9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>
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

--001a11359d106816ad0517284b27
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, May 27, 2015 at 9:43 PM, Nan Xiao <span dir=3D"ltr">&lt;<a href=
=3D"mailto:xiaonan830818@gmail.com" target=3D"_blank">xiaonan830818@gmail.c=
om</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,20=
4);border-left-style:solid;padding-left:1ex"><div dir=3D"ltr"><br clear=3D"=
all"><div><div><div dir=3D"ltr">Best Regards<span class=3D""><font color=3D=
"#888888"><div>Nan Xiao</div></font></span></div></div></div><div><div clas=
s=3D"h5">
<br><div class=3D"gmail_quote">---------- Forwarded message ----------<br>F=
rom: <b class=3D"gmail_sendername">Nan Xiao</b> <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:xiaonan830818@gmail.com" target=3D"_blank">xiaonan830818@gmail=
.com</a>&gt;</span><br>Date: Thu, May 28, 2015 at 9:42 AM<br>Subject: Re: [=
lttng-dev] Install kmod-lttng-modules error on CentOS 7<br>To: J=C3=A9r=C3=
=A9mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" targ=
et=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;<br><br><br><div dir=3D=
"ltr">After trying with SRPM, it reports the same error: =C2=A0=C2=A0<div><=
br></div><div><div>In file included from /root/rpmbuild/BUILD/lttng-modules=
-2.5.0/obj/default/probes/../instrumentation/events/lttng-module/../../../p=
robes/define_trace.h:139:0,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from /root/rpmbuild/BUILD/lttng-modules-2.5.0/ob=
j/default/probes/../instrumentation/events/lttng-module/kvm.h:381,</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /root/=
rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-probe-kvm.c:42:=
</div><div>/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../i=
nstrumentation/events/lttng-module/../../../probes/lttng-events.h:151:6: er=
ror: conflicting types for &#39;trace_kvm_async_pf_completed&#39;</div><div=
>=C2=A0void trace_##_name(_proto);</div><div>=C2=A0 =C2=A0 =C2=A0 ^</div><d=
iv>/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrumen=
tation/events/lttng-module/../../../probes/lttng-events.h:47:2: note: in ex=
pansion of macro &#39;DEFINE_EVENT_MAP&#39;</div><span><div>=C2=A0 DEFINE_E=
VENT_MAP(map, name, map, PARAMS(proto), PARAMS(args))</div><div>=C2=A0 ^</d=
iv></span><div>/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/=
../instrumentation/events/lttng-module/../../../probes/lttng-events.h:89:2:=
 note: in expansion of macro &#39;TRACE_EVENT_MAP&#39;</div><div>=C2=A0 TRA=
CE_EVENT_MAP(name, name, =C2=A0 =C2=A0\</div><div>=C2=A0 ^</div><div>/root/=
rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrumentation/ev=
ents/lttng-module/../../../probes/../instrumentation/events/lttng-module/kv=
m.h:351:1: note: in expansion of macro &#39;TRACE_EVENT&#39;</div><span><di=
v>=C2=A0TRACE_EVENT(</div><div>=C2=A0^</div><div>In file included from incl=
ude/linux/module.h:18:0,</div></span><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /root/rpmbuild/BUILD/lttng-modules-2.5.=
0/obj/default/probes/lttng-probe-kvm.c:23:</div><span><div>include/linux/tr=
acepoint.h:162:21: note: previous definition of &#39;trace_kvm_async_pf_com=
pleted&#39; was here</div><div>=C2=A0 static inline void trace_##name(proto=
) =C2=A0 =C2=A0\</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0^</div><div>include/linux/tracepoint.h:259:3: n=
ote: in expansion of macro &#39;__DECLARE_TRACE&#39;</div><div>=C2=A0 =C2=
=A0__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1, \</div><div>=C2=A0=
 =C2=A0^</div><div>include/linux/tracepoint.h:391:2: note: in expansion of =
macro &#39;DECLARE_TRACE&#39;</div><div>=C2=A0 DECLARE_TRACE(name, PARAMS(p=
roto), PARAMS(args))</div><div>=C2=A0 ^</div><div>include/trace/events/kvm.=
h:317:1: note: in expansion of macro &#39;TRACE_EVENT&#39;</div><div>=C2=A0=
TRACE_EVENT(</div><div>=C2=A0^</div></span><div>make[2]: *** [/root/rpmbuil=
d/BUILD/lttng-modules-2.5.0/obj/default/probes/lttng-probe-kvm.o] Error 1</=
div><div>make[1]: *** [/root/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default=
/probes] Error 2</div><div>make: *** [_module_/root/rpmbuild/BUILD/lttng-mo=
dules-2.5.0/obj/default] Error 2</div><div>make: Leaving directory `/usr/sr=
c/kernels/3.10.0-229.4.2.el7.x86_64&#39;</div><div>error: Bad exit status f=
rom /var/tmp/rpm-tmp.BYJgqS (%build)</div><div><br></div><div><br></div><di=
v>RPM build errors:</div><div>=C2=A0 =C2=A0 Bad exit status from /var/tmp/r=
pm-tmp.BYJgqS (%build)</div></div><div><br></div><div><br></div><div>Could =
you help to fix it and provide patch for CentOS? Thanks!</div></div></div><=
/div></div></div></blockquote><div><br></div><div>Hi Nan,</div><div><br></d=
iv><div>We have updated the packages on <a href=3D"http://packages.efficios=
.com">packages.efficios.com</a>. The issue was caused by patches backported=
 by Red Hat to their 3.10 kernel as part of the release of RHEL 7.1.</div><=
div><br></div><div>Can you check that the latest kmod-lttng-modules package=
 on the repository works?</div><div><br></div><div>The updated source RPM i=
s also available at:=C2=A0<a href=3D"http://packages.efficios.com/rhel/7/SR=
PMS/latest/lttng-modules/lttng-modules-2.5.3-1.el7.src.rpm">http://packages=
.efficios.com/rhel/7/SRPMS/latest/lttng-modules/lttng-modules-2.5.3-1.el7.s=
rc.rpm</a></div><div><br></div><div>The following patches, merged as part o=
f lttng-modules&#39; stable-2.5, stable-2.6 and master branches add the nec=
essary kernel version checks:</div><div><br></div><div><div>commit 51b96165=
3d69b56528ae8c7e4cd39d140d75f610</div><div>Author: Mathieu Desnoyers &lt;<a=
 href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.=
com</a>&gt;</div><div>Date: =C2=A0 Wed May 27 12:56:05 2015 -0400</div><div=
><br></div><div>=C2=A0 =C2=A0 Fix: RHEL 7.1 block instrumentation</div><div=
>=C2=A0 =C2=A0=C2=A0</div><div>=C2=A0 =C2=A0 Signed-off-by: Mathieu Desnoye=
rs &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@=
efficios.com</a>&gt;</div><div><br></div><div>commit f30ae671364af1a69a5c5a=
d562e10a38c1bbaf2e</div><div>Author: Mathieu Desnoyers &lt;<a href=3D"mailt=
o:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt;</d=
iv><div>Date: =C2=A0 Wed May 27 12:19:01 2015 -0400</div><div><br></div><di=
v>=C2=A0 =C2=A0 Fix: add RHEL version macros</div><div>=C2=A0 =C2=A0=C2=A0<=
/div><div>=C2=A0 =C2=A0 RHEL 7.1 has backported upstream patches that chang=
e the kvm.h</div><div>=C2=A0 =C2=A0 tracepoint prototype. Add version check=
 specific to RHEL to handle this</div><div>=C2=A0 =C2=A0 case.</div><div>=
=C2=A0 =C2=A0=C2=A0</div><div>=C2=A0 =C2=A0 RHEL 7.x has the required fixes=
 backported that allow removing the 3.10</div><div>=C2=A0 =C2=A0 blacklist =
check for them, so take this into account.</div><div>=C2=A0 =C2=A0=C2=A0</d=
iv><div>=C2=A0 =C2=A0 Signed-off-by: Mathieu Desnoyers &lt;<a href=3D"mailt=
o:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt;</d=
iv></div><div><br></div><div>Regards,</div><div>J=C3=A9r=C3=A9mie</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-=
style:solid;padding-left:1ex"><div dir=3D"ltr"><div><div class=3D"h5"><div =
class=3D"gmail_quote"><div class=3D"gmail_extra"><br clear=3D"all"><div><di=
v><div dir=3D"ltr">Best Regards<span><font color=3D"#888888"><div>Nan Xiao<=
/div></font></span></div></div></div><div><div>
<br><div class=3D"gmail_quote">On Wed, May 27, 2015 at 11:09 PM, J=C3=A9r=
=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarne=
au@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-le=
ft-style:solid;padding-left:1ex"><div dir=3D"ltr">CentOS might be using a d=
ifferent kernel (not binary compatible). Have you tried installing from the=
 source RPM [1]?<div><br></div><div>$ wget=C2=A0<a href=3D"http://packages.=
efficios.com/rhel/7/SRPMS/latest/lttng-modules/lttng-modules-2.5.0-1.el7.sr=
c.rpm" target=3D"_blank">http://packages.efficios.com/rhel/7/SRPMS/latest/l=
ttng-modules/lttng-modules-2.5.0-1.el7.src.rpm</a></div><div>$ rpm -i lttng=
-modules-2.5.0-1.el7.src.rpm</div><div>$ cd ~/rpmbuild/SPECS</div><div>$ rp=
mbuild -bb lttng-modules.spec</div><div><br></div><div>Trying this here on =
a RHEL7 machine seems to fail since the latest kernel update (3.10.0-229.4.=
2.el7.x86_64) with:</div><div><br></div><div><div>In file included from /ho=
me/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrumen=
tation/events/lttng-module/../../../probes/define_trace.h:139:0,</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /home/bu=
ild/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrumentatio=
n/events/lttng-module/kvm.h:381,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /home/build/rpmbuild/BUILD/lttng-module=
s-2.5.0/obj/default/probes/lttng-probe-kvm.c:42:</div><div>/home/build/rpmb=
uild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrumentation/events=
/lttng-module/../../../probes/lttng-events.h:151:6: error: conflicting type=
s for &#39;trace_kvm_async_pf_completed&#39;</div><div>=C2=A0void trace_##_=
name(_proto);</div><div>=C2=A0 =C2=A0 =C2=A0 ^</div><div>/home/build/rpmbui=
ld/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrumentation/events/l=
ttng-module/../../../probes/lttng-events.h:47:2: note: in expansion of macr=
o &#39;DEFINE_EVENT_MAP&#39;</div><div>=C2=A0 DEFINE_EVENT_MAP(map, name, m=
ap, PARAMS(proto), PARAMS(args))</div><div>=C2=A0 ^</div><div>/home/build/r=
pmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/../instrumentation/eve=
nts/lttng-module/../../../probes/lttng-events.h:89:2: note: in expansion of=
 macro &#39;TRACE_EVENT_MAP&#39;</div><div>=C2=A0 TRACE_EVENT_MAP(name, nam=
e, =C2=A0 =C2=A0\</div><div>=C2=A0 ^</div><div>/home/build/rpmbuild/BUILD/l=
ttng-modules-2.5.0/obj/default/probes/../instrumentation/events/lttng-modul=
e/../../../probes/../instrumentation/events/lttng-module/kvm.h:351:1: note:=
 in expansion of macro &#39;TRACE_EVENT&#39;</div><div>=C2=A0TRACE_EVENT(</=
div><div>=C2=A0^</div><div>In file included from include/linux/module.h:18:=
0,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
from /home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes/lttn=
g-probe-kvm.c:23:</div><div>include/linux/tracepoint.h:162:21: note: previo=
us definition of &#39;trace_kvm_async_pf_completed&#39; was here</div><div>=
=C2=A0 static inline void trace_##name(proto) =C2=A0 =C2=A0\</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<=
/div><div>include/linux/tracepoint.h:259:3: note: in expansion of macro &#3=
9;__DECLARE_TRACE&#39;</div><div>=C2=A0 =C2=A0__DECLARE_TRACE(name, PARAMS(=
proto), PARAMS(args), 1, \</div><div>=C2=A0 =C2=A0^</div><div>include/linux=
/tracepoint.h:391:2: note: in expansion of macro &#39;DECLARE_TRACE&#39;</d=
iv><div>=C2=A0 DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))</div><div>=
=C2=A0 ^</div><div>include/trace/events/kvm.h:317:1: note: in expansion of =
macro &#39;TRACE_EVENT&#39;</div><div>=C2=A0TRACE_EVENT(</div><div>=C2=A0^<=
/div><div>make[2]: *** [/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/=
default/probes/lttng-probe-kvm.o] Error 1</div><div>make[1]: *** [/home/bui=
ld/rpmbuild/BUILD/lttng-modules-2.5.0/obj/default/probes] Error 2</div><div=
>make: *** [_module_/home/build/rpmbuild/BUILD/lttng-modules-2.5.0/obj/defa=
ult] Error 2</div><div>make: Leaving directory `/usr/src/kernels/3.10.0-229=
.4.2.el7.x86_64&#39;</div><div>error: Bad exit status from /var/tmp/rpm-tmp=
.75xMIN (%build)</div></div><div><br></div><div>I guess this is caused by a=
 patch backported to Red Hat&#39;s 3.10 kernel. I&#39;ll investigate and se=
e what can be done.</div><div><br></div><div>Regards,</div><div>J=C3=A9r=C3=
=A9mie</div><div><br></div><div>[1]=C2=A0<a href=3D"http://packages.efficio=
s.com/rhel/7/SRPMS/latest/lttng-modules/lttng-modules-2.5.0-1.el7.src.rpm" =
target=3D"_blank">http://packages.efficios.com/rhel/7/SRPMS/latest/lttng-mo=
dules/lttng-modules-2.5.0-1.el7.src.rpm</a></div></div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote"><div><div>On Wed, May 27, 2015 at 5:4=
0 AM, Nan Xiao <span dir=3D"ltr">&lt;<a href=3D"mailto:xiaonan830818@gmail.=
com" target=3D"_blank">xiaonan830818@gmail.com</a>&gt;</span> wrote:<br></d=
iv></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-styl=
e:solid;padding-left:1ex"><div><div><div dir=3D"ltr">Hi all,<div><br></div>=
<div>I am following this page (<a href=3D"http://packages.efficios.com/" ta=
rget=3D"_blank">http://packages.efficios.com/</a>) , and try to install ltt=
ng on CentOS 7. All the modules are installed OK, except=C2=A0kmod-lttng-mo=
dules, and the error info likes this: =C2=A0</div><div><br></div><div><div>=
[root@mawent3 ~]# yum install kmod-lttng-modules</div><div>Loaded plugins: =
fastestmirror</div><div>Loading mirror speeds from cached hostfile</div><di=
v>=C2=A0* base: <a href=3D"http://centos.mirrors.tds.net" target=3D"_blank"=
>centos.mirrors.tds.net</a></div><div>=C2=A0* extras: <a href=3D"http://bay=
.uchicago.edu" target=3D"_blank">bay.uchicago.edu</a></div><div>=C2=A0* upd=
ates: <a href=3D"http://dallas.tx.mirror.xygenhosting.com" target=3D"_blank=
">dallas.tx.mirror.xygenhosting.com</a></div><div>Resolving Dependencies</d=
iv><div>--&gt; Running transaction check</div><div>---&gt; Package kmod-ltt=
ng-modules.x86_64 0:2.5.0-1.el7 will be installed</div><div>--&gt; Processi=
ng Dependency: kernel(__alloc_pages_nodemask) =3D 0xfb29f2e9 for package: k=
mod-lttng-modules-2.5.0-1.el7.x86_64</div><div>--&gt; Processing Dependency=
: kernel(node_data) =3D 0xc0ebbdec for package: kmod-lttng-modules-2.5.0-1.=
el7.x86_64</div><div>--&gt; Finished Dependency Resolution</div><div>Error:=
 Package: kmod-lttng-modules-2.5.0-1.el7.x86_64 (EfficiOS-RHEL7-x86-64)</di=
v><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Requires: kernel(node_data)=
 =3D 0xc0ebbdec</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Installe=
d: kernel-3.10.0-229.el7.x86_64 (@anaconda)</div><div>=C2=A0 =C2=A0 =C2=A0 =
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
ds<span><font color=3D"#888888"><div>Nan Xiao</div></font></span></div></di=
v></div>
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
</div><br></div></div></div>
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
</div></div>

--001a11359d106816ad0517284b27--


--===============0060355272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0060355272==--
