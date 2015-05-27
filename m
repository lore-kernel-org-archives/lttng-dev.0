From: Nan Xiao <xiaonan830818@gmail.com>
Subject: Install kmod-lttng-modules error on CentOS 7
Date: Wed, 27 May 2015 17:40:41 +0800
Message-ID: <CA+MhoaPNB3hqU0QWG3qxo9WjsmJ0DgfK1X88WMUwsN8wX=5C+Q__24683.7209830575$1432719707$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1891060756=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <xiaonan830818@gmail.com>) id 1YxXpP-0002kB-Jy
 for lttng-dev@lists.lttng.org; Wed, 27 May 2015 05:40:49 -0400
Received: by wizk4 with SMTP id k4so104950223wiz.1
 for <lttng-dev@lists.lttng.org>; Wed, 27 May 2015 02:40:41 -0700 (PDT)
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

--===============1891060756==
Content-Type: multipart/alternative; boundary=047d7bb0427250cbaf05170d09ba

--047d7bb0427250cbaf05170d09ba
Content-Type: text/plain; charset=UTF-8

Hi all,

I am following this page (http://packages.efficios.com/) , and try to
install lttng on CentOS 7. All the modules are installed OK,
except kmod-lttng-modules, and the error info likes this:

[root@mawent3 ~]# yum install kmod-lttng-modules
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: centos.mirrors.tds.net
 * extras: bay.uchicago.edu
 * updates: dallas.tx.mirror.xygenhosting.com
Resolving Dependencies
--> Running transaction check
---> Package kmod-lttng-modules.x86_64 0:2.5.0-1.el7 will be installed
--> Processing Dependency: kernel(__alloc_pages_nodemask) = 0xfb29f2e9 for
package: kmod-lttng-modules-2.5.0-1.el7.x86_64
--> Processing Dependency: kernel(node_data) = 0xc0ebbdec for package:
kmod-lttng-modules-2.5.0-1.el7.x86_64
--> Finished Dependency Resolution
Error: Package: kmod-lttng-modules-2.5.0-1.el7.x86_64
(EfficiOS-RHEL7-x86-64)
           Requires: kernel(node_data) = 0xc0ebbdec
           Installed: kernel-3.10.0-229.el7.x86_64 (@anaconda)
               kernel(node_data) = 0x3142b10b
           Installed: kernel-3.10.0-229.4.2.el7.x86_64 (@updates)
               kernel(node_data) = 0x3142b10b
           Available: kernel-3.10.0-229.1.2.el7.x86_64 (updates)
               kernel(node_data) = 0x3142b10b
           Available: kernel-debug-3.10.0-229.el7.x86_64 (base)
               kernel(node_data) = 0x7881b78f
           Available: kernel-debug-3.10.0-229.1.2.el7.x86_64 (updates)
               kernel(node_data) = 0x7881b78f
           Available: kernel-debug-3.10.0-229.4.2.el7.x86_64 (updates)
               kernel(node_data) = 0x7881b78f
Error: Package: kmod-lttng-modules-2.5.0-1.el7.x86_64
(EfficiOS-RHEL7-x86-64)
           Requires: kernel(__alloc_pages_nodemask) = 0xfb29f2e9
           Installed: kernel-3.10.0-229.el7.x86_64 (@anaconda)
               kernel(__alloc_pages_nodemask) = 0x8616cca3
           Installed: kernel-3.10.0-229.4.2.el7.x86_64 (@updates)
               kernel(__alloc_pages_nodemask) = 0x8616cca3
           Available: kernel-3.10.0-229.1.2.el7.x86_64 (updates)
               kernel(__alloc_pages_nodemask) = 0x8616cca3
           Available: kernel-debug-3.10.0-229.el7.x86_64 (base)
               kernel(__alloc_pages_nodemask) = 0xcc655c2a
           Available: kernel-debug-3.10.0-229.1.2.el7.x86_64 (updates)
               kernel(__alloc_pages_nodemask) = 0xcc655c2a
           Available: kernel-debug-3.10.0-229.4.2.el7.x86_64 (updates)
               kernel(__alloc_pages_nodemask) = 0xcc655c2a
 You could try using --skip-broken to work around the problem
 You could try running: rpm -Va --nofiles --nodigest


Could someone give help on this issue? Thanks very much in advance!

Best Regards
Nan Xiao

--047d7bb0427250cbaf05170d09ba
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>I am following this page (<a hr=
ef=3D"http://packages.efficios.com/">http://packages.efficios.com/</a>) , a=
nd try to install lttng on CentOS 7. All the modules are installed OK, exce=
pt=C2=A0kmod-lttng-modules, and the error info likes this: =C2=A0</div><div=
><br></div><div><div>[root@mawent3 ~]# yum install kmod-lttng-modules</div>=
<div>Loaded plugins: fastestmirror</div><div>Loading mirror speeds from cac=
hed hostfile</div><div>=C2=A0* base: <a href=3D"http://centos.mirrors.tds.n=
et">centos.mirrors.tds.net</a></div><div>=C2=A0* extras: <a href=3D"http://=
bay.uchicago.edu">bay.uchicago.edu</a></div><div>=C2=A0* updates: <a href=
=3D"http://dallas.tx.mirror.xygenhosting.com">dallas.tx.mirror.xygenhosting=
.com</a></div><div>Resolving Dependencies</div><div>--&gt; Running transact=
ion check</div><div>---&gt; Package kmod-lttng-modules.x86_64 0:2.5.0-1.el7=
 will be installed</div><div>--&gt; Processing Dependency: kernel(__alloc_p=
ages_nodemask) =3D 0xfb29f2e9 for package: kmod-lttng-modules-2.5.0-1.el7.x=
86_64</div><div>--&gt; Processing Dependency: kernel(node_data) =3D 0xc0ebb=
dec for package: kmod-lttng-modules-2.5.0-1.el7.x86_64</div><div>--&gt; Fin=
ished Dependency Resolution</div><div>Error: Package: kmod-lttng-modules-2.=
5.0-1.el7.x86_64 (EfficiOS-RHEL7-x86-64)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Requires: kernel(node_data) =3D 0xc0ebbdec</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Installed: kernel-3.10.0-229.el7.x86_=
64 (@anaconda)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0kernel(node_data) =3D 0x3142b10b</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Installed: kernel-3.10.0-229.4.2.el7.x86_64 (@updates)</di=
v><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(node_d=
ata) =3D 0x3142b10b</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Avai=
lable: kernel-3.10.0-229.1.2.el7.x86_64 (updates)</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(node_data) =3D 0x3142b10b</=
div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Available: kernel-debug-3=
.10.0-229.el7.x86_64 (base)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0kernel(node_data) =3D 0x7881b78f</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Available: kernel-debug-3.10.0-229.1.2.el7.x=
86_64 (updates)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0kernel(node_data) =3D 0x7881b78f</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Available: kernel-debug-3.10.0-229.4.2.el7.x86_64 (updates=
)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(n=
ode_data) =3D 0x7881b78f</div><div>Error: Package: kmod-lttng-modules-2.5.0=
-1.el7.x86_64 (EfficiOS-RHEL7-x86-64)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0Requires: kernel(__alloc_pages_nodemask) =3D 0xfb29f2e9</div>=
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Installed: kernel-3.10.0-229.=
el7.x86_64 (@anaconda)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0kernel(__alloc_pages_nodemask) =3D 0x8616cca3</div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Installed: kernel-3.10.0-229.4.2.el7.x86=
_64 (@updates)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0kernel(__alloc_pages_nodemask) =3D 0x8616cca3</div><div>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0Available: kernel-3.10.0-229.1.2.el7.x86_64 (up=
dates)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ker=
nel(__alloc_pages_nodemask) =3D 0x8616cca3</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Available: kernel-debug-3.10.0-229.el7.x86_64 (base)</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(__all=
oc_pages_nodemask) =3D 0xcc655c2a</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Available: kernel-debug-3.10.0-229.1.2.el7.x86_64 (updates)</div>=
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(__alloc_=
pages_nodemask) =3D 0xcc655c2a</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0Available: kernel-debug-3.10.0-229.4.2.el7.x86_64 (updates)</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel(__alloc_pag=
es_nodemask) =3D 0xcc655c2a</div><div>=C2=A0You could try using --skip-brok=
en to work around the problem</div><div>=C2=A0You could try running: rpm -V=
a --nofiles --nodigest</div><div><br></div><div><br></div><div>Could someon=
e give help on this issue? Thanks very much in advance!</div><div><br></div=
><div><div class=3D"gmail_signature"><div dir=3D"ltr">Best Regards<div>Nan =
Xiao</div></div></div></div>
</div></div>

--047d7bb0427250cbaf05170d09ba--


--===============1891060756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1891060756==--
