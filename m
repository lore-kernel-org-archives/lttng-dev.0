From: Rui Han <iurnah@gmail.com>
Subject: How to compile lttng-modules using full kernel source
	tree.
Date: Fri, 20 Mar 2015 09:34:02 -0400
Message-ID: <CABy43G9szQBY9eObtid3D0nDTBxm-50dSbT73MT-v_ac+4n9Tw__26545.2812695459$1426858527$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0590746334=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <iurnah@gmail.com>) id 1YYx3w-0002sW-55
 for lttng-dev@lists.lttng.org; Fri, 20 Mar 2015 09:34:13 -0400
Received: by iedfl3 with SMTP id fl3so2409762ied.1
 for <lttng-dev@lists.lttng.org>; Fri, 20 Mar 2015 06:34:02 -0700 (PDT)
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

--===============0590746334==
Content-Type: multipart/alternative; boundary=001a113fd7b29e8d200511b85e17

--001a113fd7b29e8d200511b85e17
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I have encountered following output when I try to run make from the
lttng-modules source cloned from git repo. I have tried in a clean install
of both 12.04 and 14.04.

make -C /lib/modules/3.13.0-45-generic/build
M=3D/home/troguard32/lttng/lttng-modules modules
make[1]: Entering directory `/usr/src/linux-headers-3.13.0-45-generic'
/home/troguard32/lttng/lttng-modules/probes/Makefile:30: File
/usr/src/linux-headers-3.13.0-45-generic/virt/kvm/iodev.h not found.
Probe "kvm" x86-specific is disabled. Use full kernel source tree to
enable it.
/home/troguard32/lttng/lttng-modules/probes/Makefile:142: Files
/usr/src/linux-headers-3.13.0-45-generic/fs/btrfs/*.h not found. Probe
"btrfs" is disabled. Use full kernel source tree to enable it.
/home/troguard32/lttng/lttng-modules/probes/Makefile:158: Files
/usr/src/linux-headers-3.13.0-45-generic/fs/ext4/*.h not found. Probe
"ext4" is disabled. Use full kernel source tree to enable it.
  Building modules, stage 2.
  MODPOST 43 modules
make[1]: Leaving directory `/usr/src/linux-headers-3.13.0-45-generic'

when run make modules_install, it seem the installation is successful, but
the output is abnormal, giving repeated =E2=80=9CCan=E2=80=99t read private=
 key=E2=80=9D messages.

If I ignore this message and install all other lttng components, it seems
lttng kernel tracer is working fine.

My question is,

   1. How to completely remove this abnormal message? where to specify the
   full kernel source path in make file? (I am a makefile beginner)
   2. How to check whether the lttng-modules installed is fully functional
   or not?
   3. Does the above message is just telling me that I will be able to use
   the full function of lttng-modules except those file system probe mentio=
ned
   in the make output?

Thank you very much.

Best regards,
Rui
=E2=80=8B

--001a113fd7b29e8d200511b85e17
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"markdown-here-wrapper" style><p style=3D"mar=
gin:1.2em 0px!important">Hi,</p>
<p style=3D"margin:1.2em 0px!important">I have encountered following output=
 when I try to run make from the lttng-modules source cloned from git repo.=
 I have tried in a clean install of both 12.04 and 14.04.</p>
<pre style=3D"font-size:0.85em;font-family:Consolas,Inconsolata,Courier,mon=
ospace;font-size:1em;line-height:1.2em;margin:1.2em 0px"><code style=3D"fon=
t-size:0.85em;font-family:Consolas,Inconsolata,Courier,monospace;margin:0px=
 0.15em;padding:0px 0.3em;white-space:pre-wrap;border:1px solid rgb(234,234=
,234);border-radius:3px;display:inline;background-color:rgb(248,248,248);wh=
ite-space:pre;overflow:auto;border-radius:3px;border:1px solid rgb(204,204,=
204);padding:0.5em 0.7em;display:block!important">make -C /lib/modules/3.13=
.0-45-generic/build M=3D/home/troguard32/lttng/lttng-modules modules
make[1]: Entering directory `/usr/src/linux-headers-3.13.0-45-generic&#39;
/home/troguard32/lttng/lttng-modules/probes/Makefile:30: File /usr/src/linu=
x-headers-3.13.0-45-generic/virt/kvm/iodev.h not found. Probe &quot;kvm&quo=
t; x86-specific is disabled. Use full kernel source tree to enable it.
/home/troguard32/lttng/lttng-modules/probes/Makefile:142: Files /usr/src/li=
nux-headers-3.13.0-45-generic/fs/btrfs/*.h not found. Probe &quot;btrfs&quo=
t; is disabled. Use full kernel source tree to enable it.
/home/troguard32/lttng/lttng-modules/probes/Makefile:158: Files /usr/src/li=
nux-headers-3.13.0-45-generic/fs/ext4/*.h not found. Probe &quot;ext4&quot;=
 is disabled. Use full kernel source tree to enable it.
  Building modules, stage 2.
  MODPOST 43 modules
make[1]: Leaving directory `/usr/src/linux-headers-3.13.0-45-generic&#39;
</code></pre><p style=3D"margin:1.2em 0px!important">when run make modules_=
install, it seem the installation is successful, but the output is abnormal=
, giving repeated =E2=80=9CCan=E2=80=99t read private key=E2=80=9D messages=
.</p>
<p style=3D"margin:1.2em 0px!important">If I ignore this message and instal=
l all other lttng components, it seems lttng kernel tracer is working fine.=
 </p>
<p style=3D"margin:1.2em 0px!important">My question is,</p>
<ol style=3D"margin:1.2em 0px;padding-left:2em">
<li style=3D"margin:0.5em 0px">How to completely remove this abnormal messa=
ge? where to specify the full kernel source path in make file? (I am a make=
file beginner)</li>
<li style=3D"margin:0.5em 0px">How to check whether the lttng-modules insta=
lled is fully functional or not?</li>
<li style=3D"margin:0.5em 0px">Does the above message is just telling me th=
at I will be able to use the full function of lttng-modules except those fi=
le system probe mentioned in the make output? </li>
</ol>
<p style=3D"margin:1.2em 0px!important">Thank you very much.</p>
<p style=3D"margin:1.2em 0px!important">Best regards,<br>Rui</p>
<div title=3D"MDH:SGksPGRpdj48YnI+PC9kaXY+PGRpdj5JIGhhdmUgZW5jb3VudGVyZWQgZ=
m9sbG93aW5nIG91dHB1
dCB3aGVuIEkgdHJ5IHRvIHJ1biBtYWtlIGZyb20gdGhlIGx0dG5nLW1vZHVsZXMgc291cmNlIGN=
s
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
:0em;padding:0;margin:0">=E2=80=8B</div></div></div>

--001a113fd7b29e8d200511b85e17--


--===============0590746334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0590746334==--
