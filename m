From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: How to compile lttng-modules using full kernel
 source tree.
Date: Mon, 23 Mar 2015 13:42:51 +0000 (UTC)
Message-ID: <1333465971.74742.1427118171635.JavaMail.zimbra__34191.0283816562$1427118243$gmane$org@efficios.com>
References: <CABy43G9szQBY9eObtid3D0nDTBxm-50dSbT73MT-v_ac+4n9Tw@mail.gmail.com>
 <550C3074.2010409@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1970063146=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Ya2d7-0007dh-PB
 for lttng-dev@lists.lttng.org; Mon, 23 Mar 2015 09:42:59 -0400
In-Reply-To: <550C3074.2010409@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1970063146==
Content-Type: multipart/alternative;
	boundary="----=_Part_74741_858076168.1427118171634"

------=_Part_74741_858076168.1427118171634
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> Hey,
> See comments below.

> On 2015-03-20 09:34 AM, Rui Han wrote:

> > Hi,
>=20

> > I have encountered following output when I try to run make from the
> > lttng-modules source cloned from git repo. I have tried in a clean inst=
all
> > of both 12.04 and 14.04.
>=20
> > make -C /lib/modules/3.13.0-45-generic/build
> > M=3D/home/troguard32/lttng/lttng-modules modules
>=20
> > make[1]: Entering directory `/usr/src/linux-headers-3.13.0-45-generic'
>=20
> > /home/troguard32/lttng/lttng-modules/probes/Makefile:30: File
> > /usr/src/linux-headers-3.13.0-45-generic/virt/kvm/iodev.h not found. Pr=
obe
> > "kvm" x86-specific is disabled. Use full kernel source tree to enable i=
t.
>=20
> > /home/troguard32/lttng/lttng-modules/probes/Makefile:142: Files
> > /usr/src/linux-headers-3.13.0-45-generic/fs/btrfs/*.h not found. Probe
> > "btrfs" is disabled. Use full kernel source tree to enable it.
>=20
> > /home/troguard32/lttng/lttng-modules/probes/Makefile:158: Files
> > /usr/src/linux-headers-3.13.0-45-generic/fs/ext4/*.h not found. Probe
> > "ext4"
> > is disabled. Use full kernel source tree to enable it.
>=20
> > Building modules, stage 2.
>=20
> > MODPOST 43 modules
>=20
> > make[1]: Leaving directory `/usr/src/linux-headers-3.13.0-45-generic'
>=20

> > when run make modules_install, it seem the installation is successful, =
but
> > the output is abnormal, giving repeated =E2=80=9CCan=E2=80=99t read pri=
vate key=E2=80=9D messages.
>=20

> > If I ignore this message and install all other lttng components, it see=
ms
> > lttng kernel tracer is working fine.
>=20

> > My question is,
>=20

> > 1. How to completely remove this abnormal message? where to specify the
> > full
> > kernel source path in make file? (I am a makefile beginner)
>=20

> Abnormal message being the key related one? We are looking into but this =
does
> not in any way change behavior.
It's because you are building against your distribution kernel, for which=
=20
only your distribution has the signing key. Therefore, the build complains=
=20
that the modules are not signed. But since your distro kernel allows=20
loading unsigned modules, it works fine, but outputs a warning.=20

> As for the warning for kvm/btrfs/ext4. Nothing to worry about you simply
> don't have these components installed on your system.
A small correction: you may have kvm/btrfs/ext4 on your system. However, lt=
tng-modules=20
is letting you know that it cannot build the probes to attach to those subs=
ystem, because=20
you build against the installed kernel headers, rather than against the ful=
l kernel source tree.=20
This is because those subsystem place their instrumentation headers into su=
bdirectories of=20
the Linux kernel tree that are not installed on the system.=20

Thanks,=20

Mathieu=20

> > 1. How to check whether the lttng-modules installed is fully functional=
 or
> > not?
>=20

> A quick check is the one you probably did: lttng list -k. You can also ru=
n
> the root_regression tests from lttng-tools. Under ./tests you can run
> ./run.sh root_regression while being root.

> > 1. Does the above message is just telling me that I will be able to use=
 the
> > full function of lttng-modules except those file system probe mentioned=
 in
> > the make output?
>=20

> Exactly.

> > Thank you very much.
>=20

> > Best regards,
>=20
> > Rui
>=20
> > =E2=80=8B
>=20

> > _______________________________________________
>=20
> > lttng-dev mailing list lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>=20

> --
> Jonathan R. Julien
> Efficios

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_74741_858076168.1427118171634
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;">
 =20
   =20
 =20
 =20
    Hey,<br>
    See comments below.<br><br><div class=3D"moz-cite-prefix">On 2015-03-20=
 09:34 AM, Rui Han wrote:<br></div><blockquote cite=3D"mid:CABy43G9szQBY9eO=
btid3D0nDTBxm-50dSbT73MT-v_ac+4n9Tw@mail.gmail.com"><div dir=3D"ltr"><div c=
lass=3D"markdown-here-wrapper" style=3D""><p style=3D"margin:1.2em 0px!impo=
rtant">Hi,</p><p style=3D"margin:1.2em 0px!important">I have encountered
            following output when I try to run make from the
            lttng-modules source cloned from git repo. I have tried in a
            clean install of both 12.04 and 14.04.</p><pre style=3D"font-si=
ze:0.85em;font-family:Consolas,Inconsolata,Courier,monospace;font-size:1em;=
line-height:1.2em;margin:1.2em 0px"><code style=3D"font-size:0.85em;font-fa=
mily:Consolas,Inconsolata,Courier,monospace;margin:0px 0.15em;padding:0px 0=
.3em;white-space:pre-wrap;border:1px solid rgb(234,234,234);border-radius:3=
px;display:inline;background-color:rgb(248,248,248);white-space:pre;overflo=
w:auto;border-radius:3px;border:1px solid rgb(204,204,204);padding:0.5em 0.=
7em;display:block!important">make -C /lib/modules/3.13.0-45-generic/build M=
=3D/home/troguard32/lttng/lttng-modules modules
make[1]: Entering directory `/usr/src/linux-headers-3.13.0-45-generic'
/home/troguard32/lttng/lttng-modules/probes/Makefile:30: File /usr/src/linu=
x-headers-3.13.0-45-generic/virt/kvm/iodev.h not found. Probe "kvm" x86-spe=
cific is disabled. Use full kernel source tree to enable it.
/home/troguard32/lttng/lttng-modules/probes/Makefile:142: Files /usr/src/li=
nux-headers-3.13.0-45-generic/fs/btrfs/*.h not found. Probe "btrfs" is disa=
bled. Use full kernel source tree to enable it.
/home/troguard32/lttng/lttng-modules/probes/Makefile:158: Files /usr/src/li=
nux-headers-3.13.0-45-generic/fs/ext4/*.h not found. Probe "ext4" is disabl=
ed. Use full kernel source tree to enable it.
  Building modules, stage 2.
  MODPOST 43 modules
make[1]: Leaving directory `/usr/src/linux-headers-3.13.0-45-generic'
</code></pre><p style=3D"margin:1.2em 0px!important">when run make
            modules_install, it seem the installation is successful, but
            the output is abnormal, giving repeated =E2=80=9CCan=E2=80=99t =
read private
            key=E2=80=9D messages.</p><p style=3D"margin:1.2em 0px!importan=
t">If I ignore this message
            and install all other lttng components, it seems lttng
            kernel tracer is working fine. </p><p style=3D"margin:1.2em 0px=
!important">My question is,</p><ol style=3D"margin:1.2em 0px;padding-left:2=
em"><li style=3D"margin:0.5em 0px">How to completely remove this
              abnormal message? where to specify the full kernel source
              path in make file? (I am a makefile beginner)</li></ol></div>=
</div></blockquote>
    Abnormal message being the key related one? We are looking into but
    this does not in any way change behavior.</blockquote><div>It's because=
 you are building against your distribution kernel, for which<br></div><div=
>only your distribution has the signing key. Therefore, the build complains=
<br></div><div>that the modules are not signed. But since your distro kerne=
l allows<br></div><div>loading unsigned modules, it works fine, but outputs=
 a warning.</div><div><br></div><blockquote style=3D"border-left:2px solid =
#1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font=
-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;f=
ont-size:12pt;"><br>
    As for the warning for kvm/btrfs/ext4. Nothing to worry about you
    simply don't have these components installed on your system.</blockquot=
e><div>A small correction: you may have kvm/btrfs/ext4 on your system. Howe=
ver, lttng-modules<br></div><div>is letting you know that it cannot build t=
he probes to attach to those subsystem, because<br></div><div>you build aga=
inst the installed kernel headers, rather than against the full kernel sour=
ce tree.<br></div><div>This is because those subsystem place their instrume=
ntation headers into subdirectories of<br></div><div>the Linux kernel tree =
that are not installed on the system.<br></div><div><br></div><div>Thanks,<=
br></div><div><br></div><div>Mathieu<br></div><div><br></div><div><br></div=
><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding=
-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:n=
one;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><br><blockquote=
 cite=3D"mid:CABy43G9szQBY9eObtid3D0nDTBxm-50dSbT73MT-v_ac+4n9Tw@mail.gmail=
.com"><div dir=3D"ltr"><div class=3D"markdown-here-wrapper" style=3D""><ol =
style=3D"margin:1.2em 0px;padding-left:2em"><li style=3D"margin:0.5em 0px">=
How to check whether the
              lttng-modules installed is fully functional or not?</li></ol>=
</div></div></blockquote>
    A quick check is the one you probably did: lttng list -k. You can
    also run the root_regression tests from lttng-tools. Under ./tests
    you can run ./run.sh root_regression while being root.<br><blockquote c=
ite=3D"mid:CABy43G9szQBY9eObtid3D0nDTBxm-50dSbT73MT-v_ac+4n9Tw@mail.gmail.c=
om"><div dir=3D"ltr"><div class=3D"markdown-here-wrapper" style=3D""><ol st=
yle=3D"margin:1.2em 0px;padding-left:2em"><li style=3D"margin:0.5em 0px">Do=
es the above message is just
              telling me that I will be able to use the full function of
              lttng-modules except those file system probe mentioned in
              the make output? </li></ol></div></div></blockquote>
    Exactly. <br><blockquote cite=3D"mid:CABy43G9szQBY9eObtid3D0nDTBxm-50dS=
bT73MT-v_ac+4n9Tw@mail.gmail.com"><div dir=3D"ltr"><div class=3D"markdown-h=
ere-wrapper" style=3D""><p style=3D"margin:1.2em 0px!important">Thank you v=
ery much.</p><p style=3D"margin:1.2em 0px!important">Best regards,<br>
            Rui</p><div title=3D"MDH:SGksPGRpdj48YnI+PC9kaXY+PGRpdj5JIGhhdm=
UgZW5jb3VudGVyZWQgZm9sbG93aW5nIG91dHB1dCB3aGVuIEkgdHJ5IHRvIHJ1biBtYWtlIGZyb=
20gdGhlIGx0dG5nLW1vZHVsZXMgc291cmNlIGNs
b25lZCBmcm9tIGdpdCByZXBvLiBJIGhhdmUgdHJpZWQgaW4gYSBjbGVhbiBpbnN0YWxsIG9mIGJ=
v
dGggMTIuMDQgYW5kIDE0LjA0LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+YGBgPC9kaXY+PGR=
p
dj48ZGl2Pm1ha2UgLUMgL2xpYi9tb2R1bGVzLzMuMTMuMC00NS1nZW5lcmljL2J1aWxkIE09L2h=
v
bWUvdHJvZ3VhcmQzMi9sdHRuZy9sdHRuZy1tb2R1bGVzIG1vZHVsZXM8L2Rpdj48ZGl2Pm1ha2V=
b
MV06IEVudGVyaW5nIGRpcmVjdG9yeSBgL3Vzci9zcmMvbGludXgtaGVhZGVycy0zLjEzLjAtNDU=
t
Z2VuZXJpYyc8L2Rpdj48ZGl2Pi9ob21lL3Ryb2d1YXJkMzIvbHR0bmcvbHR0bmctbW9kdWxlcy9=
w
cm9iZXMvTWFrZWZpbGU6MzA6IEZpbGUgL3Vzci9zcmMvbGludXgtaGVhZGVycy0zLjEzLjAtNDU=
t
Z2VuZXJpYy92aXJ0L2t2bS9pb2Rldi5oIG5vdCBmb3VuZC4gUHJvYmUgImt2bSIgeDg2LXNwZWN=
p
ZmljIGlzIGRpc2FibGVkLiBVc2UgZnVsbCBrZXJuZWwgc291cmNlIHRyZWUgdG8gZW5hYmxlIGl=
0
LjwvZGl2PjxkaXY+L2hvbWUvdHJvZ3VhcmQzMi9sdHRuZy9sdHRuZy1tb2R1bGVzL3Byb2Jlcy9=
N
YWtlZmlsZToxNDI6IEZpbGVzIC91c3Ivc3JjL2xpbnV4LWhlYWRlcnMtMy4xMy4wLTQ1LWdlbmV=
y
aWMvZnMvYnRyZnMvKi5oIG5vdCBmb3VuZC4gUHJvYmUgImJ0cmZzIiBpcyBkaXNhYmxlZC4gVXN=
l
IGZ1bGwga2VybmVsIHNvdXJjZSB0cmVlIHRvIGVuYWJsZSBpdC48L2Rpdj48ZGl2Pi9ob21lL3R=
y
b2d1YXJkMzIvbHR0bmcvbHR0bmctbW9kdWxlcy9wcm9iZXMvTWFrZWZpbGU6MTU4OiBGaWxlcyA=
v
dXNyL3NyYy9saW51eC1oZWFkZXJzLTMuMTMuMC00NS1nZW5lcmljL2ZzL2V4dDQvKi5oIG5vdCB=
m
b3VuZC4gUHJvYmUgImV4dDQiIGlzIGRpc2FibGVkLiBVc2UgZnVsbCBrZXJuZWwgc291cmNlIHR=
y
ZWUgdG8gZW5hYmxlIGl0LjwvZGl2PjxkaXY+Jm5ic3A7IEJ1aWxkaW5nIG1vZHVsZXMsIHN0YWd=
l
IDIuPC9kaXY+PGRpdj4mbmJzcDsgTU9EUE9TVCA0MyBtb2R1bGVzPC9kaXY+PGRpdj5tYWtlWzF=
d
OiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Vzci9zcmMvbGludXgtaGVhZGVycy0zLjEzLjAtNDUtZ2V=
u
ZXJpYyc8L2Rpdj48L2Rpdj48ZGl2PmBgYDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+d2hlbiB=
y
dW4gbWFrZSBtb2R1bGVzX2luc3RhbGwsIGl0IHNlZW0gdGhlIGluc3RhbGxhdGlvbiBpcyBzdWN=
j
ZXNzZnVsLCBidXQgdGhlIG91dHB1dCBpcyBhYm5vcm1hbCwgZ2l2aW5nIHJlcGVhdGVkICJDYW4=
n
dCByZWFkIHByaXZhdGUga2V5IiBtZXNzYWdlcy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkl=
m
IEkgaWdub3JlIHRoaXMgbWVzc2FnZSBhbmQgaW5zdGFsbCBhbGwgb3RoZXIgbHR0bmcgY29tcG9=
u
ZW50cywgaXQgc2VlbXMgbHR0bmcga2VybmVsIHRyYWNlciBpcyB3b3JraW5nIGZpbmUuJm5ic3A=
7
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5NeSBxdWVzdGlvbiBpcyw8L2Rpdj48ZGl2PjEuIEh=
v
dyB0byBjb21wbGV0ZWx5IHJlbW92ZSB0aGlzIGFibm9ybWFsIG1lc3NhZ2U/IHdoZXJlIHRvIHN=
w
ZWNpZnkgdGhlIGZ1bGwga2VybmVsIHNvdXJjZSBwYXRoIGluIG1ha2UgZmlsZT8gKEkgYW0gYSB=
t
YWtlZmlsZSBiZWdpbm5lcik8L2Rpdj48ZGl2PjIuIEhvdyB0byBjaGVjayB3aGV0aGVyIHRoZSB=
s
dHRuZy1tb2R1bGVzIGluc3RhbGxlZCBpcyBmdWxseSBmdW5jdGlvbmFsIG9yIG5vdD88L2Rpdj4=
8
ZGl2PjMuIERvZXMgdGhlIGFib3ZlIG1lc3NhZ2UgaXMganVzdCB0ZWxsaW5nIG1lIHRoYXQgSSB=
3
aWxsIGJlIGFibGUgdG8gdXNlIHRoZSBmdWxsIGZ1bmN0aW9uIG9mIGx0dG5nLW1vZHVsZXMgZXh=
j
ZXB0IHRob3NlIGZpbGUgc3lzdGVtIHByb2JlIG1lbnRpb25lZCBpbiB0aGUgbWFrZSBvdXRwdXQ=
/
Jm5ic3A7PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFuayB5b3UgdmVyeSBtdWNoLjwvZGl=
2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+QmVzdCByZWdhcmRzLDwvZGl2PjxkaXY+UnVpPC9kaXY+" s=
tyle=3D"height:0;width:0;max-height:0;max-width:0;overflow:hidden;font-size=
:0em;padding:0;margin:0">=E2=80=8B</div></div></div><br><br><pre>__________=
_____________________________________
lttng-dev mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lttng-dev@lists.lttng.=
org" target=3D"_blank">lttng-dev@lists.lttng.org</a><a class=3D"moz-txt-lin=
k-freetext" href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-d=
ev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng=
-dev</a><br data-mce-bogus=3D"1"></pre></blockquote><br><pre class=3D"moz-s=
ignature">--=20
Jonathan R. Julien
Efficios</pre><br>_______________________________________________<br>lttng-=
dev mailing list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi=
-bin/mailman/listinfo/lttng-dev<br></blockquote><div><br><br></div><div><br=
></div><div>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>=
EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"></span><br></div><=
/div></body></html>
------=_Part_74741_858076168.1427118171634--


--===============1970063146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1970063146==--
