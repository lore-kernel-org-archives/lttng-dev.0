From: Rui Han <iurnah@gmail.com>
Subject: Re: How to compile lttng-modules using full kernel
	source tree.
Date: Mon, 23 Mar 2015 10:03:20 -0400
Message-ID: <CABy43G-k3HjEC00Z+=-P58qNkbEOu1WCpmSqORarUqAStFMZmA__21133.7033812471$1427119484$gmane$org@mail.gmail.com>
References: <CABy43G9szQBY9eObtid3D0nDTBxm-50dSbT73MT-v_ac+4n9Tw@mail.gmail.com>
 <550C3074.2010409@efficios.com>
 <1333465971.74742.1427118171635.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1218072980=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <iurnah@gmail.com>) id 1Ya2ww-0007tk-4N
 for lttng-dev@lists.lttng.org; Mon, 23 Mar 2015 10:03:28 -0400
Received: by igbud6 with SMTP id ud6so42841100igb.1
 for <lttng-dev@lists.lttng.org>; Mon, 23 Mar 2015 07:03:20 -0700 (PDT)
In-Reply-To: <1333465971.74742.1427118171635.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1218072980==
Content-Type: multipart/alternative; boundary=001a113fd7b2ee1b200511f52064

--001a113fd7b2ee1b200511f52064
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Mathieu,

Thank you very much for your reply.

Where in make file can I specify the full kernel source path? I found the
following makefile snippet but I cannot locate where the $(srctree)
variable is initialized. Could you please give me some insight or point to
the related material? Thank you very much.

ifneq ($(CONFIG_EXT4_FS),) ext4_dep =3D $(srctree)/fs/ext4/*.h ext4 =3D
lttng-probe-ext4.o
ifeq ($(wildcard $(ext4_dep)),) $(warning Files $(ext4_dep) not found.
Probe "ext4" is disabled. Use full kernel source tree to enable it.)
ext4 =3D
endif
obj-m +=3D $(ext4)
endif

Regards,
Rui

On Mon, Mar 23, 2015 at 9:42 AM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

------------------------------
>
> Hey,
> See comments below.
>
> On 2015-03-20 09:34 AM, Rui Han wrote:
>
> Hi,
>
> I have encountered following output when I try to run make from the
> lttng-modules source cloned from git repo. I have tried in a clean instal=
l
> of both 12.04 and 14.04.
>
> make -C /lib/modules/3.13.0-45-generic/build M=3D/home/troguard32/lttng/l=
ttng-modules modules
> make[1]: Entering directory `/usr/src/linux-headers-3.13.0-45-generic'
> /home/troguard32/lttng/lttng-modules/probes/Makefile:30: File /usr/src/li=
nux-headers-3.13.0-45-generic/virt/kvm/iodev.h not found. Probe "kvm" x86-s=
pecific is disabled. Use full kernel source tree to enable it.
> /home/troguard32/lttng/lttng-modules/probes/Makefile:142: Files /usr/src/=
linux-headers-3.13.0-45-generic/fs/btrfs/*.h not found. Probe "btrfs" is di=
sabled. Use full kernel source tree to enable it.
> /home/troguard32/lttng/lttng-modules/probes/Makefile:158: Files /usr/src/=
linux-headers-3.13.0-45-generic/fs/ext4/*.h not found. Probe "ext4" is disa=
bled. Use full kernel source tree to enable it.
>   Building modules, stage 2.
>   MODPOST 43 modules
> make[1]: Leaving directory `/usr/src/linux-headers-3.13.0-45-generic'
>
> when run make modules_install, it seem the installation is successful, bu=
t
> the output is abnormal, giving repeated =E2=80=9CCan=E2=80=99t read priva=
te key=E2=80=9D messages.
>
> If I ignore this message and install all other lttng components, it seems
> lttng kernel tracer is working fine.
>
> My question is,
>
>    1. How to completely remove this abnormal message? where to specify
>    the full kernel source path in make file? (I am a makefile beginner)
>
> Abnormal message being the key related one? We are looking into but this
> does not in any way change behavior.
>
> It's because you are building against your distribution kernel, for which
> only your distribution has the signing key. Therefore, the build complain=
s
> that the modules are not signed. But since your distro kernel allows
> loading unsigned modules, it works fine, but outputs a warning.
>
>
> As for the warning for kvm/btrfs/ext4. Nothing to worry about you simply
> don't have these components installed on your system.
>
> A small correction: you may have kvm/btrfs/ext4 on your system. However,
> lttng-modules
> is letting you know that it cannot build the probes to attach to those
> subsystem, because
> you build against the installed kernel headers, rather than against the
> full kernel source tree.
> This is because those subsystem place their instrumentation headers into
> subdirectories of
> the Linux kernel tree that are not installed on the system.
>
> Thanks,
>
> Mathieu
>
>
>
>
>    1. How to check whether the lttng-modules installed is fully
>    functional or not?
>
> A quick check is the one you probably did: lttng list -k. You can also ru=
n
> the root_regression tests from lttng-tools. Under ./tests you can run
> ./run.sh root_regression while being root.
>
>
>    1. Does the above message is just telling me that I will be able to
>    use the full function of lttng-modules except those file system probe
>    mentioned in the make output?
>
> Exactly.
>
> Thank you very much.
>
> Best regards,
> Rui
> =E2=80=8B
>
>
> _______________________________________________
> lttng-dev mailing listlttng-dev@lists.lttng.orghttp://lists.lttng.org/cgi=
-bin/mailman/listinfo/lttng-dev
>
>
> --
> Jonathan R. Julien
> Efficios
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
=E2=80=8B

--001a113fd7b2ee1b200511f52064
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"markdown-here-wrapper" style><p style=3D"mar=
gin:1.2em 0px!important">Hi Mathieu,</p>
<p style=3D"margin:1.2em 0px!important">Thank you very much for your reply.=
 </p>
<p style=3D"margin:1.2em 0px!important">Where in make file can I specify th=
e full kernel source path? I found the following makefile snippet but I can=
not locate where the $(srctree) variable is initialized. Could you please g=
ive me some insight or point to the related material? Thank you very much.<=
/p>
<pre style=3D"font-size:0.85em;font-family:Consolas,Inconsolata,Courier,mon=
ospace;font-size:1em;line-height:1.2em;margin:1.2em 0px"><code class=3D"hlj=
s language-makefile" style=3D"font-size:0.85em;font-family:Consolas,Inconso=
lata,Courier,monospace;margin:0px 0.15em;padding:0px 0.3em;white-space:pre-=
wrap;border:1px solid rgb(234,234,234);border-radius:3px;display:inline;bac=
kground-color:rgb(248,248,248);white-space:pre;overflow:auto;border-radius:=
3px;border:1px solid rgb(204,204,204);padding:0.5em 0.7em;display:block!imp=
ortant;display:block;overflow-x:auto;padding:0.5em;color:rgb(51,51,51);back=
ground:rgb(248,248,248)">ifneq ($(CONFIG_EXT4_FS),)=20
<span class=3D"hljs-constant">ext4_dep</span> =3D <span class=3D"hljs-varia=
ble" style=3D"color:rgb(0,128,128)">$(srctree)</span>/fs/ext4/*.h=20
<span class=3D"hljs-constant">ext4</span> =3D lttng-probe-ext4.o=20
ifeq ($(wildcard $(ext4_dep)),) $(warning Files $(ext4_dep) not found. Prob=
e &quot;ext4&quot; is disabled. Use full kernel source tree to enable it.)=
=20
<span class=3D"hljs-constant">ext4</span> =3D=20
endif=20
obj-m +=3D $(ext4)=20
endif
</code></pre>
<p style=3D"margin:1.2em 0px!important">Regards,<br>Rui</p>
<p style=3D"margin:1.2em 0px!important">On Mon, Mar 23, 2015 at 9:42 AM, Ma=
thieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" targe=
t=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt; wrote:</p>
<p style=3D"margin:1.2em 0px!important"></p><div class=3D"markdown-here-exc=
lude"><p></p><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-=
style:solid;padding-left:1ex"><div><div style=3D"font-family:&#39;times new=
 roman&#39;,&#39;new york&#39;,times,serif;font-size:12pt;color:rgb(0,0,0)"=
><hr><span class=3D""><blockquote style=3D"border-left-width:2px;border-lef=
t-style:solid;border-left-color:rgb(16,16,255);margin-left:5px;padding-left=
:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration:=
none;font-family:Helvetica,Arial,sans-serif;font-size:12pt">
 =20
   =20
 =20
 =20
    Hey,<br>
    See comments below.<br><br><div>On 2015-03-20 09:34 AM, Rui Han wrote:<=
br></div><blockquote><div dir=3D"ltr"><div><p style=3D"margin:1.2em 0px!imp=
ortant">Hi,</p><p style=3D"margin:1.2em 0px!important">I have encountered
            following output when I try to run make from the
            lttng-modules source cloned from git repo. I have tried in a
            clean install of both 12.04 and 14.04.</p><pre style=3D"font-fa=
mily:Consolas,Inconsolata,Courier,monospace;font-size:1em;line-height:1.2em=
;margin:1.2em 0px"><code style=3D"font-size:0.85em;font-family:Consolas,Inc=
onsolata,Courier,monospace;margin:0px 0.15em;white-space:pre-wrap;overflow:=
auto;border-radius:3px;border:1px solid rgb(204,204,204);padding:0.5em 0.7e=
m;display:block!important;background-color:rgb(248,248,248)">make -C /lib/m=
odules/3.13.0-45-generic/build M=3D/home/troguard32/lttng/lttng-modules mod=
ules
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
    this does not in any way change behavior.</blockquote></span><div>It&#3=
9;s because you are building against your distribution kernel, for which<br=
></div><div>only your distribution has the signing key. Therefore, the buil=
d complains<br></div><div>that the modules are not signed. But since your d=
istro kernel allows<br></div><div>loading unsigned modules, it works fine, =
but outputs a warning.</div><span class=3D""><div><br></div><blockquote sty=
le=3D"border-left-width:2px;border-left-style:solid;border-left-color:rgb(1=
6,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:nor=
mal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans=
-serif;font-size:12pt"><br>
    As for the warning for kvm/btrfs/ext4. Nothing to worry about you
    simply don&#39;t have these components installed on your system.</block=
quote></span><div>A small correction: you may have kvm/btrfs/ext4 on your s=
ystem. However, lttng-modules<br></div><div>is letting you know that it can=
not build the probes to attach to those subsystem, because<br></div><div>yo=
u build against the installed kernel headers, rather than against the full =
kernel source tree.<br></div><div>This is because those subsystem place the=
ir instrumentation headers into subdirectories of<br></div><div>the Linux k=
ernel tree that are not installed on the system.<br></div><div><br></div><d=
iv>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><br></div><di=
v><br></div><blockquote style=3D"border-left-width:2px;border-left-style:so=
lid;border-left-color:rgb(16,16,255);margin-left:5px;padding-left:5px;color=
:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration:none;font-=
family:Helvetica,Arial,sans-serif;font-size:12pt"><span class=3D""><br><blo=
ckquote><div dir=3D"ltr"><div><ol style=3D"margin:1.2em 0px;padding-left:2e=
m"><li style=3D"margin:0.5em 0px">How to check whether the
              lttng-modules installed is fully functional or not?</li></ol>=
</div></div></blockquote>
    A quick check is the one you probably did: lttng list -k. You can
    also run the root_regression tests from lttng-tools. Under ./tests
    you can run ./run.sh root_regression while being root.<br><blockquote><=
div dir=3D"ltr"><div><ol style=3D"margin:1.2em 0px;padding-left:2em"><li st=
yle=3D"margin:0.5em 0px">Does the above message is just
              telling me that I will be able to use the full function of
              lttng-modules except those file system probe mentioned in
              the make output? </li></ol></div></div></blockquote>
    Exactly. <br></span><blockquote><span class=3D""><div dir=3D"ltr"><div>=
<p style=3D"margin:1.2em 0px!important">Thank you very much.</p><p style=3D=
"margin:1.2em 0px!important">Best regards,<br>
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
tyle=3D"min-height:0px;width:0px;max-height:0px;max-width:0px;overflow:hidd=
en;font-size:0em;padding:0px;margin:0px">=E2=80=8B</div></div></div><br><br=
></span><pre>_______________________________________________
lttng-dev mailing list
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo=
/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listin=
fo/lttng-dev</a><br></pre></blockquote><span class=3D""><br><pre>--=20
Jonathan R. Julien
Efficios</pre><br>_______________________________________________<br>lttng-=
dev mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"=
_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"http://lists.lttng.org/=
cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.or=
g/cgi-bin/mailman/listinfo/lttng-dev</a><br></span></blockquote><span class=
=3D""><font color=3D"#888888"><div><br><br></div><div><br></div><div>-- <br=
></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br><=
a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.co=
m</a><span name=3D"x"></span><br></div></font></span></div></div></blockquo=
te><p></p></div><p style=3D"margin:1.2em 0px!important"></p>
<div title=3D"MDH:PGRpdj5IaSBNYXRoaWV1LDxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48Z=
Gl2PlRoYW5rIHlvdSB2
ZXJ5IG11Y2ggZm9yIHlvdXIgcmVwbHkuJm5ic3A7PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5=
X
aGVyZSBpbiBtYWtlIGZpbGUgY2FuIEkgc3BlY2lmeSB0aGUgZnVsbCBrZXJuZWwgc291cmNlIHB=
h
dGg/IEkgZm91bmQgdGhlIGZvbGxvd2luZyBtYWtlZmlsZSBzbmlwcGV0IGJ1dCBJIGNhbm5vdCB=
s
b2NhdGUgd2hlcmUgdGhlICQoc3JjdHJlZSkgdmFyaWFibGUgaXMgaW5pdGlhbGl6ZWQuIENvdWx=
k
IHlvdSBwbGVhc2UgZ2l2ZSBtZSBzb21lIGluc2lnaHQgb3IgcG9pbnQgdG8gdGhlIHJlbGF0ZWQ=
g
bWF0ZXJpYWw/IFRoYW5rIHlvdSB2ZXJ5IG11Y2guPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4=
8
ZGl2PmBgYG1ha2VmaWxlPC9kaXY+PGRpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGZvbnQ=
g
Y29sb3I9IiMzMzMzMzMiIGZhY2U9IkhlbHZldGljYSwgYXJpYWwsIG5pbWJ1c3NhbnNsLCBsaWJ=
l
cmF0aW9uc2FucywgZnJlZXNhbnMsIGNsZWFuLCBzYW5zLXNlcmlmLCBTZWdvZSBVSSBFbW9qaSw=
g
U2Vnb2UgVUkgU3ltYm9sIj48c3BhbiBzdHlsZT0ibGluZS1oZWlnaHQ6IDE4LjIwMDAwMDc2Mjk=
z
OTVweDsiPmlmbmVxICgkKENPTkZJR19FWFQ0X0ZTKSwpJm5ic3A7PC9zcGFuPjwvZm9udD48L2R=
p
dj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGZvbnQgY29sb3I9IiMzMzMzMzMiIGZhY2U9Ikh=
l
bHZldGljYSwgYXJpYWwsIG5pbWJ1c3NhbnNsLCBsaWJlcmF0aW9uc2FucywgZnJlZXNhbnMsIGN=
s
ZWFuLCBzYW5zLXNlcmlmLCBTZWdvZSBVSSBFbW9qaSwgU2Vnb2UgVUkgU3ltYm9sIj48c3BhbiB=
z
dHlsZT0ibGluZS1oZWlnaHQ6IDE4LjIwMDAwMDc2MjkzOTVweDsiPmV4dDRfZGVwID0gJChzcmN=
0
cmVlKS9mcy9leHQ0LyouaCZuYnNwOzwvc3Bhbj48L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21=
h
aWxfZXh0cmEiPjxmb250IGNvbG9yPSIjMzMzMzMzIiBmYWNlPSJIZWx2ZXRpY2EsIGFyaWFsLCB=
u
aW1idXNzYW5zbCwgbGliZXJhdGlvbnNhbnMsIGZyZWVzYW5zLCBjbGVhbiwgc2Fucy1zZXJpZiw=
g
U2Vnb2UgVUkgRW1vamksIFNlZ29lIFVJIFN5bWJvbCI+PHNwYW4gc3R5bGU9ImxpbmUtaGVpZ2h=
0
OiAxOC4yMDAwMDA3NjI5Mzk1cHg7Ij5leHQ0ID0gbHR0bmctcHJvYmUtZXh0NC5vJm5ic3A7PC9=
z
cGFuPjwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGZvbnQgY29sb3I9IiM=
z
MzMzMzMiIGZhY2U9IkhlbHZldGljYSwgYXJpYWwsIG5pbWJ1c3NhbnNsLCBsaWJlcmF0aW9uc2F=
u
cywgZnJlZXNhbnMsIGNsZWFuLCBzYW5zLXNlcmlmLCBTZWdvZSBVSSBFbW9qaSwgU2Vnb2UgVUk=
g
U3ltYm9sIj48c3BhbiBzdHlsZT0ibGluZS1oZWlnaHQ6IDE4LjIwMDAwMDc2MjkzOTVweDsiPml=
m
ZXEgKCQod2lsZGNhcmQgJChleHQ0X2RlcCkpLCkgJCh3YXJuaW5nIEZpbGVzICQoZXh0NF9kZXA=
p
IG5vdCBmb3VuZC4gUHJvYmUgImV4dDQiIGlzIGRpc2FibGVkLiBVc2UgZnVsbCBrZXJuZWwgc29=
1
cmNlIHRyZWUgdG8gZW5hYmxlIGl0LikmbmJzcDs8L3NwYW4+PC9mb250PjwvZGl2PjxkaXYgY2x=
h
c3M9ImdtYWlsX2V4dHJhIj48Zm9udCBjb2xvcj0iIzMzMzMzMyIgZmFjZT0iSGVsdmV0aWNhLCB=
h
cmlhbCwgbmltYnVzc2Fuc2wsIGxpYmVyYXRpb25zYW5zLCBmcmVlc2FucywgY2xlYW4sIHNhbnM=
t
c2VyaWYsIFNlZ29lIFVJIEVtb2ppLCBTZWdvZSBVSSBTeW1ib2wiPjxzcGFuIHN0eWxlPSJsaW5=
l
LWhlaWdodDogMTguMjAwMDAwNzYyOTM5NXB4OyI+ZXh0NCA9Jm5ic3A7PC9zcGFuPjwvZm9udD4=
8
L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGZvbnQgY29sb3I9IiMzMzMzMzMiIGZhY2U=
9
IkhlbHZldGljYSwgYXJpYWwsIG5pbWJ1c3NhbnNsLCBsaWJlcmF0aW9uc2FucywgZnJlZXNhbnM=
s
IGNsZWFuLCBzYW5zLXNlcmlmLCBTZWdvZSBVSSBFbW9qaSwgU2Vnb2UgVUkgU3ltYm9sIj48c3B=
h
biBzdHlsZT0ibGluZS1oZWlnaHQ6IDE4LjIwMDAwMDc2MjkzOTVweDsiPmVuZGlmJm5ic3A7PC9=
z
cGFuPjwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGZvbnQgY29sb3I9IiM=
z
MzMzMzMiIGZhY2U9IkhlbHZldGljYSwgYXJpYWwsIG5pbWJ1c3NhbnNsLCBsaWJlcmF0aW9uc2F=
u
cywgZnJlZXNhbnMsIGNsZWFuLCBzYW5zLXNlcmlmLCBTZWdvZSBVSSBFbW9qaSwgU2Vnb2UgVUk=
g
U3ltYm9sIj48c3BhbiBzdHlsZT0ibGluZS1oZWlnaHQ6IDE4LjIwMDAwMDc2MjkzOTVweDsiPm9=
i
ai1tICs9ICQoZXh0NCkmbmJzcDs8L3NwYW4+PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWl=
s
X2V4dHJhIj48Zm9udCBjb2xvcj0iIzMzMzMzMyIgZmFjZT0iSGVsdmV0aWNhLCBhcmlhbCwgbml=
t
YnVzc2Fuc2wsIGxpYmVyYXRpb25zYW5zLCBmcmVlc2FucywgY2xlYW4sIHNhbnMtc2VyaWYsIFN=
l
Z29lIFVJIEVtb2ppLCBTZWdvZSBVSSBTeW1ib2wiPjxzcGFuIHN0eWxlPSJsaW5lLWhlaWdodDo=
g
MTguMjAwMDAwNzYyOTM5NXB4OyI+ZW5kaWY8L3NwYW4+PC9mb250PjwvZGl2PjxkaXYgY2xhc3M=
9
ImdtYWlsX2V4dHJhIj48Zm9udCBjb2xvcj0iIzMzMzMzMyIgZmFjZT0iSGVsdmV0aWNhLCBhcml=
h
bCwgbmltYnVzc2Fuc2wsIGxpYmVyYXRpb25zYW5zLCBmcmVlc2FucywgY2xlYW4sIHNhbnMtc2V=
y
aWYsIFNlZ29lIFVJIEVtb2ppLCBTZWdvZSBVSSBTeW1ib2wiPjxzcGFuIHN0eWxlPSJsaW5lLWh=
l
aWdodDogMTguMjAwMDAwNzYyOTM5NXB4OyI+YGBgPC9zcGFuPjwvZm9udD48L2Rpdj48L2Rpdj4=
8
L2Rpdj48ZGl2PlJlZ2FyZHMsPC9kaXY+PGRpdj5SdWk8L2Rpdj48ZGl2PiZuYnNwOzxicj48L2R=
p
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48ZGl2IGNsYXN=
z
PSJnbWFpbF9xdW90ZSI+T24gTW9uLCBNYXIgMjMsIDIwMTUgYXQgOTo0MiBBTSwgTWF0aGlldSB=
E
ZXNub3llcnMgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86bWF0aGlldS5kZXN=
u
b3llcnNAZWZmaWNpb3MuY29tIiB0YXJnZXQ9Il9ibGFuayI+bWF0aGlldS5kZXNub3llcnNAZWZ=
m
aWNpb3MuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX3F=
1
b3RlIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46IDBweCA=
w
cHggMHB4IDAuOGV4OyBib3JkZXItbGVmdC13aWR0aDogMXB4OyBib3JkZXItbGVmdC1jb2xvcjo=
g
cmdiKDIwNCwgMjA0LCAyMDQpOyBib3JkZXItbGVmdC1zdHlsZTogc29saWQ7IHBhZGRpbmctbGV=
m
dDogMWV4OyI+PGRpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTogJ3RpbWVzIG5ldyByb21hbic=
s
ICduZXcgeW9yaycsIHRpbWVzLCBzZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDA=
s
IDAsIDApOyI+PGhyPjxzcGFuIGNsYXNzPSIiPjxibG9ja3F1b3RlIHN0eWxlPSJib3JkZXItbGV=
m
dC13aWR0aDogMnB4OyBib3JkZXItbGVmdC1zdHlsZTogc29saWQ7IGJvcmRlci1sZWZ0LWNvbG9=
y
OiByZ2IoMTYsIDE2LCAyNTUpOyBtYXJnaW4tbGVmdDogNXB4OyBwYWRkaW5nLWxlZnQ6IDVweDs=
g
Y29sb3I6IHJnYigwLCAwLCAwKTsgZm9udC13ZWlnaHQ6IG5vcm1hbDsgZm9udC1zdHlsZTogbm9=
y
bWFsOyB0ZXh0LWRlY29yYXRpb246IG5vbmU7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2EsIEFyaWF=
s
LCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7Ij4KICAKICAgIAogIAogIAogICAgSGV5LDx=
i
cj4KICAgIFNlZSBjb21tZW50cyBiZWxvdy48YnI+PGJyPjxkaXY+T24gMjAxNS0wMy0yMCAwOTo=
z
NCBBTSwgUnVpIEhhbiB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGU+PGRpdiBkaXI9Imx0ciI=
+
PGRpdj48cCBzdHlsZT0ibWFyZ2luOiAxLjJlbSAwcHggIWltcG9ydGFudDsiPkhpLDwvcD48cCB=
z
dHlsZT0ibWFyZ2luOiAxLjJlbSAwcHggIWltcG9ydGFudDsiPkkgaGF2ZSBlbmNvdW50ZXJlZAo=
g
ICAgICAgICAgICBmb2xsb3dpbmcgb3V0cHV0IHdoZW4gSSB0cnkgdG8gcnVuIG1ha2UgZnJvbSB=
0
aGUKICAgICAgICAgICAgbHR0bmctbW9kdWxlcyBzb3VyY2UgY2xvbmVkIGZyb20gZ2l0IHJlcG8=
u
IEkgaGF2ZSB0cmllZCBpbiBhCiAgICAgICAgICAgIGNsZWFuIGluc3RhbGwgb2YgYm90aCAxMi4=
w
NCBhbmQgMTQuMDQuPC9wPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBDb25zb2xhcywgSW5jb25=
z
b2xhdGEsIENvdXJpZXIsIG1vbm9zcGFjZTsgZm9udC1zaXplOiAxZW07IGxpbmUtaGVpZ2h0OiA=
x
LjJlbTsgbWFyZ2luOiAxLjJlbSAwcHg7Ij48Y29kZSBzdHlsZT0iZm9udC1zaXplOiAwLjg1ZW0=
7
IGZvbnQtZmFtaWx5OiBDb25zb2xhcywgSW5jb25zb2xhdGEsIENvdXJpZXIsIG1vbm9zcGFjZTs=
g
bWFyZ2luOiAwcHggMC4xNWVtOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7IG92ZXJmbG93OiBhdXR=
v
OyBib3JkZXItcmFkaXVzOiAzcHg7IGJvcmRlcjogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA=
0
KTsgcGFkZGluZzogMC41ZW0gMC43ZW07IGRpc3BsYXk6IGJsb2NrICFpbXBvcnRhbnQ7IGJhY2t=
n
cm91bmQtY29sb3I6IHJnYigyNDgsIDI0OCwgMjQ4KTsiPm1ha2UgLUMgL2xpYi9tb2R1bGVzLzM=
u
MTMuMC00NS08d2JyPmdlbmVyaWMvYnVpbGQgTT0vaG9tZS90cm9ndWFyZDMyL2x0dG5nLzx3YnI=
+
bHR0bmctbW9kdWxlcyBtb2R1bGVzCm1ha2VbMV06IEVudGVyaW5nIGRpcmVjdG9yeSBgL3Vzci9=
z
cmMvbGludXgtaGVhZGVycy0zLjEzLjx3YnI+MC00NS1nZW5lcmljJwovaG9tZS90cm9ndWFyZDM=
y
L2x0dG5nL2x0dG5nLTx3YnI+bW9kdWxlcy9wcm9iZXMvTWFrZWZpbGU6MzA6IEZpbGUgL3Vzci9=
z
cmMvbGludXgtaGVhZGVycy0zLjEzLjAtPHdicj40NS1nZW5lcmljL3ZpcnQva3ZtL2lvZGV2Lmg=
g
bm90IGZvdW5kLiBQcm9iZSAia3ZtIiB4ODYtc3BlY2lmaWMgaXMgZGlzYWJsZWQuIFVzZSBmdWx=
s
IGtlcm5lbCBzb3VyY2UgdHJlZSB0byBlbmFibGUgaXQuCi9ob21lL3Ryb2d1YXJkMzIvbHR0bmc=
v
bHR0bmctPHdicj5tb2R1bGVzL3Byb2Jlcy9NYWtlZmlsZToxNDI6IEZpbGVzIC91c3Ivc3JjL2x=
p
bnV4LWhlYWRlcnMtMy4xMy4wLTx3YnI+NDUtZ2VuZXJpYy9mcy9idHJmcy8qLmggbm90IGZvdW5=
k
LiBQcm9iZSAiYnRyZnMiIGlzIGRpc2FibGVkLiBVc2UgZnVsbCBrZXJuZWwgc291cmNlIHRyZWU=
g
dG8gZW5hYmxlIGl0LgovaG9tZS90cm9ndWFyZDMyL2x0dG5nL2x0dG5nLTx3YnI+bW9kdWxlcy9=
w
cm9iZXMvTWFrZWZpbGU6MTU4OiBGaWxlcyAvdXNyL3NyYy9saW51eC1oZWFkZXJzLTMuMTMuMC0=
8
d2JyPjQ1LWdlbmVyaWMvZnMvZXh0NC8qLmggbm90IGZvdW5kLiBQcm9iZSAiZXh0NCIgaXMgZGl=
z
YWJsZWQuIFVzZSBmdWxsIGtlcm5lbCBzb3VyY2UgdHJlZSB0byBlbmFibGUgaXQuCiAgQnVpbGR=
p
bmcgbW9kdWxlcywgc3RhZ2UgMi4KICBNT0RQT1NUIDQzIG1vZHVsZXMKbWFrZVsxXTogTGVhdml=
u
ZyBkaXJlY3RvcnkgYC91c3Ivc3JjL2xpbnV4LWhlYWRlcnMtMy4xMy48d2JyPjAtNDUtZ2VuZXJ=
p
YycKPC9jb2RlPjwvcHJlPjxwIHN0eWxlPSJtYXJnaW46IDEuMmVtIDBweCAhaW1wb3J0YW50OyI=
+
d2hlbiBydW4gbWFrZQogICAgICAgICAgICBtb2R1bGVzX2luc3RhbGwsIGl0IHNlZW0gdGhlIGl=
u
c3RhbGxhdGlvbiBpcyBzdWNjZXNzZnVsLCBidXQKICAgICAgICAgICAgdGhlIG91dHB1dCBpcyB=
h
Ym5vcm1hbCwgZ2l2aW5nIHJlcGVhdGVkIOKAnENhbuKAmXQgcmVhZCBwcml2YXRlCiAgICAgICA=
g
ICAgIGtleeKAnSBtZXNzYWdlcy48L3A+PHAgc3R5bGU9Im1hcmdpbjogMS4yZW0gMHB4ICFpbXB=
v
cnRhbnQ7Ij5JZiBJIGlnbm9yZSB0aGlzIG1lc3NhZ2UKICAgICAgICAgICAgYW5kIGluc3RhbGw=
g
YWxsIG90aGVyIGx0dG5nIGNvbXBvbmVudHMsIGl0IHNlZW1zIGx0dG5nCiAgICAgICAgICAgIGt=
l
cm5lbCB0cmFjZXIgaXMgd29ya2luZyBmaW5lLiA8L3A+PHAgc3R5bGU9Im1hcmdpbjogMS4yZW0=
g
MHB4ICFpbXBvcnRhbnQ7Ij5NeSBxdWVzdGlvbiBpcyw8L3A+PG9sIHN0eWxlPSJtYXJnaW46IDE=
u
MmVtIDBweDsgcGFkZGluZy1sZWZ0OiAyZW07Ij48bGkgc3R5bGU9Im1hcmdpbjogMC41ZW0gMHB=
4
OyI+SG93IHRvIGNvbXBsZXRlbHkgcmVtb3ZlIHRoaXMKICAgICAgICAgICAgICBhYm5vcm1hbCB=
t
ZXNzYWdlPyB3aGVyZSB0byBzcGVjaWZ5IHRoZSBmdWxsIGtlcm5lbCBzb3VyY2UKICAgICAgICA=
g
ICAgICBwYXRoIGluIG1ha2UgZmlsZT8gKEkgYW0gYSBtYWtlZmlsZSBiZWdpbm5lcik8L2xpPjw=
v
b2w+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPgogICAgQWJub3JtYWwgbWVzc2FnZSBiZWluZyB=
0
aGUga2V5IHJlbGF0ZWQgb25lPyBXZSBhcmUgbG9va2luZyBpbnRvIGJ1dAogICAgdGhpcyBkb2V=
z
IG5vdCBpbiBhbnkgd2F5IGNoYW5nZSBiZWhhdmlvci48L2Jsb2NrcXVvdGU+PC9zcGFuPjxkaXY=
+
SXQncyBiZWNhdXNlIHlvdSBhcmUgYnVpbGRpbmcgYWdhaW5zdCB5b3VyIGRpc3RyaWJ1dGlvbiB=
r
ZXJuZWwsIGZvciB3aGljaDxicj48L2Rpdj48ZGl2Pm9ubHkgeW91ciBkaXN0cmlidXRpb24gaGF=
z
IHRoZSBzaWduaW5nIGtleS4gVGhlcmVmb3JlLCB0aGUgYnVpbGQgY29tcGxhaW5zPGJyPjwvZGl=
2
PjxkaXY+dGhhdCB0aGUgbW9kdWxlcyBhcmUgbm90IHNpZ25lZC4gQnV0IHNpbmNlIHlvdXIgZGl=
z
dHJvIGtlcm5lbCBhbGxvd3M8YnI+PC9kaXY+PGRpdj5sb2FkaW5nIHVuc2lnbmVkIG1vZHVsZXM=
s
IGl0IHdvcmtzIGZpbmUsIGJ1dCBvdXRwdXRzIGEgd2FybmluZy48L2Rpdj48c3BhbiBjbGFzcz0=
i
Ij48ZGl2Pjxicj48L2Rpdj48YmxvY2txdW90ZSBzdHlsZT0iYm9yZGVyLWxlZnQtd2lkdGg6IDJ=
w
eDsgYm9yZGVyLWxlZnQtc3R5bGU6IHNvbGlkOyBib3JkZXItbGVmdC1jb2xvcjogcmdiKDE2LCA=
x
NiwgMjU1KTsgbWFyZ2luLWxlZnQ6IDVweDsgcGFkZGluZy1sZWZ0OiA1cHg7IGNvbG9yOiByZ2I=
o
MCwgMCwgMCk7IGZvbnQtd2VpZ2h0OiBub3JtYWw7IGZvbnQtc3R5bGU6IG5vcm1hbDsgdGV4dC1=
k
ZWNvcmF0aW9uOiBub25lOyBmb250LWZhbWlseTogSGVsdmV0aWNhLCBBcmlhbCwgc2Fucy1zZXJ=
p
ZjsgZm9udC1zaXplOiAxMnB0OyI+PGJyPgogICAgQXMgZm9yIHRoZSB3YXJuaW5nIGZvciBrdm0=
v
YnRyZnMvZXh0NC4gTm90aGluZyB0byB3b3JyeSBhYm91dCB5b3UKICAgIHNpbXBseSBkb24ndCB=
o
YXZlIHRoZXNlIGNvbXBvbmVudHMgaW5zdGFsbGVkIG9uIHlvdXIgc3lzdGVtLjwvYmxvY2txdW9=
0
ZT48L3NwYW4+PGRpdj5BIHNtYWxsIGNvcnJlY3Rpb246IHlvdSBtYXkgaGF2ZSBrdm0vYnRyZnM=
v
ZXh0NCBvbiB5b3VyIHN5c3RlbS4gSG93ZXZlciwgbHR0bmctbW9kdWxlczxicj48L2Rpdj48ZGl=
2
PmlzIGxldHRpbmcgeW91IGtub3cgdGhhdCBpdCBjYW5ub3QgYnVpbGQgdGhlIHByb2JlcyB0byB=
h
dHRhY2ggdG8gdGhvc2Ugc3Vic3lzdGVtLCBiZWNhdXNlPGJyPjwvZGl2PjxkaXY+eW91IGJ1aWx=
k
IGFnYWluc3QgdGhlIGluc3RhbGxlZCBrZXJuZWwgaGVhZGVycywgcmF0aGVyIHRoYW4gYWdhaW5=
z
dCB0aGUgZnVsbCBrZXJuZWwgc291cmNlIHRyZWUuPGJyPjwvZGl2PjxkaXY+VGhpcyBpcyBiZWN=
h
dXNlIHRob3NlIHN1YnN5c3RlbSBwbGFjZSB0aGVpciBpbnN0cnVtZW50YXRpb24gaGVhZGVycyB=
p
bnRvIHN1YmRpcmVjdG9yaWVzIG9mPGJyPjwvZGl2PjxkaXY+dGhlIExpbnV4IGtlcm5lbCB0cmV=
l
IHRoYXQgYXJlIG5vdCBpbnN0YWxsZWQgb24gdGhlIHN5c3RlbS48YnI+PC9kaXY+PGRpdj48YnI=
+
PC9kaXY+PGRpdj5UaGFua3MsPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+TWF0aGlldTx=
i
cj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48YmxvY2txdW90ZSBzdHlsZT0=
i
Ym9yZGVyLWxlZnQtd2lkdGg6IDJweDsgYm9yZGVyLWxlZnQtc3R5bGU6IHNvbGlkOyBib3JkZXI=
t
bGVmdC1jb2xvcjogcmdiKDE2LCAxNiwgMjU1KTsgbWFyZ2luLWxlZnQ6IDVweDsgcGFkZGluZy1=
s
ZWZ0OiA1cHg7IGNvbG9yOiByZ2IoMCwgMCwgMCk7IGZvbnQtd2VpZ2h0OiBub3JtYWw7IGZvbnQ=
t
c3R5bGU6IG5vcm1hbDsgdGV4dC1kZWNvcmF0aW9uOiBub25lOyBmb250LWZhbWlseTogSGVsdmV=
0
aWNhLCBBcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyI+PHNwYW4gY2xhc3M9IiI=
+
PGJyPjxibG9ja3F1b3RlPjxkaXYgZGlyPSJsdHIiPjxkaXY+PG9sIHN0eWxlPSJtYXJnaW46IDE=
u
MmVtIDBweDsgcGFkZGluZy1sZWZ0OiAyZW07Ij48bGkgc3R5bGU9Im1hcmdpbjogMC41ZW0gMHB=
4
OyI+SG93IHRvIGNoZWNrIHdoZXRoZXIgdGhlCiAgICAgICAgICAgICAgbHR0bmctbW9kdWxlcyB=
p
bnN0YWxsZWQgaXMgZnVsbHkgZnVuY3Rpb25hbCBvciBub3Q/PC9saT48L29sPjwvZGl2PjwvZGl=
2
PjwvYmxvY2txdW90ZT4KICAgIEEgcXVpY2sgY2hlY2sgaXMgdGhlIG9uZSB5b3UgcHJvYmFibHk=
g
ZGlkOiBsdHRuZyBsaXN0IC1rLiBZb3UgY2FuCiAgICBhbHNvIHJ1biB0aGUgcm9vdF9yZWdyZXN=
z
aW9uIHRlc3RzIGZyb20gbHR0bmctdG9vbHMuIFVuZGVyIC4vdGVzdHMKICAgIHlvdSBjYW4gcnV=
u
IC4vcnVuLnNoIHJvb3RfcmVncmVzc2lvbiB3aGlsZSBiZWluZyByb290Ljxicj48YmxvY2txdW9=
0
ZT48ZGl2IGRpcj0ibHRyIj48ZGl2PjxvbCBzdHlsZT0ibWFyZ2luOiAxLjJlbSAwcHg7IHBhZGR=
p
bmctbGVmdDogMmVtOyI+PGxpIHN0eWxlPSJtYXJnaW46IDAuNWVtIDBweDsiPkRvZXMgdGhlIGF=
i
b3ZlIG1lc3NhZ2UgaXMganVzdAogICAgICAgICAgICAgIHRlbGxpbmcgbWUgdGhhdCBJIHdpbGw=
g
YmUgYWJsZSB0byB1c2UgdGhlIGZ1bGwgZnVuY3Rpb24gb2YKICAgICAgICAgICAgICBsdHRuZy1=
t
b2R1bGVzIGV4Y2VwdCB0aG9zZSBmaWxlIHN5c3RlbSBwcm9iZSBtZW50aW9uZWQgaW4KICAgICA=
g
ICAgICAgICB0aGUgbWFrZSBvdXRwdXQ/IDwvbGk+PC9vbD48L2Rpdj48L2Rpdj48L2Jsb2NrcXV=
v
dGU+CiAgICBFeGFjdGx5LiA8YnI+PC9zcGFuPjxibG9ja3F1b3RlPjxzcGFuIGNsYXNzPSIiPjx=
k
aXYgZGlyPSJsdHIiPjxkaXY+PHAgc3R5bGU9Im1hcmdpbjogMS4yZW0gMHB4ICFpbXBvcnRhbnQ=
7
Ij5UaGFuayB5b3UgdmVyeSBtdWNoLjwvcD48cCBzdHlsZT0ibWFyZ2luOiAxLjJlbSAwcHggIWl=
t
cG9ydGFudDsiPkJlc3QgcmVnYXJkcyw8YnI+CiAgICAgICAgICAgIFJ1aTwvcD48ZGl2IHRpdGx=
l
PSJNREg6U0drc1BHUnBkajQ4WW5JK1BDOWthWFkrUEdScGRqNUpJR2hoZG1VZ1pXNWpiM1Z1ZEd=
W
eVpXUWdabTlzYkc5M2FXNW5JRzkxZEhCMWRDQjNhR1Z1SUVrZ2RISjVJSFJ2SUhKMWJpQnRZV3R=
s
SUdaeWIyMGdkR2hsSUd4MGRHNW5MVzF2WkhWc1pYTWdjMjkxY21ObElHTnMKYjI1bFpDQm1jbTl=
0
SUdkcGRDQnlaWEJ2TGlCSklHaGhkbVVnZEhKcFpXUWdhVzRnWVNCamJHVmhiaUJwYm5OMFlXeHN=
J
RzltSUdKdgpkR2dnTVRJdU1EUWdZVzVrSURFMExqQTBMand2WkdsMlBqeGthWFkrUEdKeVBqd3Z=
a
R2wyUGp4a2FYWStZR0JnUEM5a2FYWStQR1JwCmRqNDhaR2wyUG0xaGEyVWdMVU1nTDJ4cFlpOXR=
i
MlIxYkdWekx6TXVNVE11TUMwME5TMW5aVzVsY21sakwySjFhV3hrSUUwOUwyaHYKYldVdmRISnZ=
a
M1ZoY21Rek1pOXNkSFJ1Wnk5c2RIUnVaeTF0YjJSMWJHVnpJRzF2WkhWc1pYTThMMlJwZGo0OFp=
H
bDJQbTFoYTJWYgpNVjA2SUVWdWRHVnlhVzVuSUdScGNtVmpkRzl5ZVNCZ0wzVnpjaTl6Y21NdmJ=
H
bHVkWGd0YUdWaFpHVnljeTB6TGpFekxqQXRORFV0CloyVnVaWEpwWXljOEwyUnBkajQ4WkdsMlB=
p
OW9iMjFsTDNSeWIyZDFZWEprTXpJdmJIUjBibWN2YkhSMGJtY3RiVzlrZFd4bGN5OXcKY205aVp=
Y
TXZUV0ZyWldacGJHVTZNekE2SUVacGJHVWdMM1Z6Y2k5emNtTXZiR2x1ZFhndGFHVmhaR1Z5Y3k=
w
ekxqRXpMakF0TkRVdApaMlZ1WlhKcFl5OTJhWEowTDJ0MmJTOXBiMlJsZGk1b0lHNXZkQ0JtYjN=
W
dVpDNGdVSEp2WW1VZ0ltdDJiU0lnZURnMkxYTndaV05wClptbGpJR2x6SUdScGMyRmliR1ZrTGl=
C
VmMyVWdablZzYkNCclpYSnVaV3dnYzI5MWNtTmxJSFJ5WldVZ2RHOGdaVzVoWW14bElHbDAKTGp=
3
dlpHbDJQanhrYVhZK0wyaHZiV1V2ZEhKdlozVmhjbVF6TWk5c2RIUnVaeTlzZEhSdVp5MXRiMlI=
x
YkdWekwzQnliMkpsY3k5TgpZV3RsWm1sc1pUb3hOREk2SUVacGJHVnpJQzkxYzNJdmMzSmpMMnh=
w
Ym5WNExXaGxZV1JsY25NdE15NHhNeTR3TFRRMUxXZGxibVZ5CmFXTXZabk12WW5SeVpuTXZLaTV=
v
SUc1dmRDQm1iM1Z1WkM0Z1VISnZZbVVnSW1KMGNtWnpJaUJwY3lCa2FYTmhZbXhsWkM0Z1ZYTmw=
K
SUdaMWJHd2dhMlZ5Ym1Wc0lITnZkWEpqWlNCMGNtVmxJSFJ2SUdWdVlXSnNaU0JwZEM0OEwyUnB=
k
ajQ4WkdsMlBpOW9iMjFsTDNSeQpiMmQxWVhKa016SXZiSFIwYm1jdmJIUjBibWN0Ylc5a2RXeGx=
j
eTl3Y205aVpYTXZUV0ZyWldacGJHVTZNVFU0T2lCR2FXeGxjeUF2CmRYTnlMM055WXk5c2FXNTF=
l
QzFvWldGa1pYSnpMVE11TVRNdU1DMDBOUzFuWlc1bGNtbGpMMlp6TDJWNGREUXZLaTVvSUc1dmR=
D
Qm0KYjNWdVpDNGdVSEp2WW1VZ0ltVjRkRFFpSUdseklHUnBjMkZpYkdWa0xpQlZjMlVnWm5Wc2J=
D
QnJaWEp1Wld3Z2MyOTFjbU5sSUhSeQpaV1VnZEc4Z1pXNWhZbXhsSUdsMExqd3ZaR2wyUGp4a2F=
Y
WStKbTVpYzNBN0lFSjFhV3hrYVc1bklHMXZaSFZzWlhNc0lITjBZV2RsCklESXVQQzlrYVhZK1B=
H
UnBkajRtYm1KemNEc2dUVTlFVUU5VFZDQTBNeUJ0YjJSMWJHVnpQQzlrYVhZK1BHUnBkajV0WVd=
0
bFd6RmQKT2lCTVpXRjJhVzVuSUdScGNtVmpkRzl5ZVNCZ0wzVnpjaTl6Y21NdmJHbHVkWGd0YUd=
W
aFpHVnljeTB6TGpFekxqQXRORFV0WjJWdQpaWEpwWXljOEwyUnBkajQ4TDJScGRqNDhaR2wyUG1=
C
Z1lEd3ZaR2wyUGp4a2FYWStQR0p5UGp3dlpHbDJQanhrYVhZK2QyaGxiaUJ5CmRXNGdiV0ZyWlN=
C
dGIyUjFiR1Z6WDJsdWMzUmhiR3dzSUdsMElITmxaVzBnZEdobElHbHVjM1JoYkd4aGRHbHZiaUJ=
w
Y3lCemRXTmoKWlhOelpuVnNMQ0JpZFhRZ2RHaGxJRzkxZEhCMWRDQnBjeUJoWW01dmNtMWhiQ3d=
n
WjJsMmFXNW5JSEpsY0dWaGRHVmtJQ0pEWVc0bgpkQ0J5WldGa0lIQnlhWFpoZEdVZ2EyVjVJaUJ=
0
WlhOellXZGxjeTQ4TDJScGRqNDhaR2wyUGp4aWNqNDhMMlJwZGo0OFpHbDJQa2xtCklFa2dhV2R=
1
YjNKbElIUm9hWE1nYldWemMyRm5aU0JoYm1RZ2FXNXpkR0ZzYkNCaGJHd2diM1JvWlhJZ2JIUjB=
i
bWNnWTI5dGNHOXUKWlc1MGN5d2dhWFFnYzJWbGJYTWdiSFIwYm1jZ2EyVnlibVZzSUhSeVlXTmx=
j
aUJwY3lCM2IzSnJhVzVuSUdacGJtVXVKbTVpYzNBNwpQQzlrYVhZK1BHUnBkajQ4WW5JK1BDOWt=
h
WFkrUEdScGRqNU5lU0J4ZFdWemRHbHZiaUJwY3l3OEwyUnBkajQ4WkdsMlBqRXVJRWh2CmR5QjB=
i
eUJqYjIxd2JHVjBaV3g1SUhKbGJXOTJaU0IwYUdseklHRmlibTl5YldGc0lHMWxjM05oWjJVL0l=
I
ZG9aWEpsSUhSdklITncKWldOcFpua2dkR2hsSUdaMWJHd2dhMlZ5Ym1Wc0lITnZkWEpqWlNCd1l=
Y
Um9JR2x1SUcxaGEyVWdabWxzWlQ4Z0tFa2dZVzBnWVNCdApZV3RsWm1sc1pTQmlaV2RwYm01bGN=
p
azhMMlJwZGo0OFpHbDJQakl1SUVodmR5QjBieUJqYUdWamF5QjNhR1YwYUdWeUlIUm9aU0JzCmR=
I
UnVaeTF0YjJSMWJHVnpJR2x1YzNSaGJHeGxaQ0JwY3lCbWRXeHNlU0JtZFc1amRHbHZibUZzSUc=
5
eUlHNXZkRDg4TDJScGRqNDgKWkdsMlBqTXVJRVJ2WlhNZ2RHaGxJR0ZpYjNabElHMWxjM05oWjJ=
V
Z2FYTWdhblZ6ZENCMFpXeHNhVzVuSUcxbElIUm9ZWFFnU1NCMwphV3hzSUdKbElHRmliR1VnZEc=
4
Z2RYTmxJSFJvWlNCbWRXeHNJR1oxYm1OMGFXOXVJRzltSUd4MGRHNW5MVzF2WkhWc1pYTWdaWGh=
q
ClpYQjBJSFJvYjNObElHWnBiR1VnYzNsemRHVnRJSEJ5YjJKbElHMWxiblJwYjI1bFpDQnBiaUI=
w
YUdVZ2JXRnJaU0J2ZFhSd2RYUS8KSm01aWMzQTdQQzlrYVhZK1BHUnBkajQ4WW5JK1BDOWthWFk=
r
UEdScGRqNVVhR0Z1YXlCNWIzVWdkbVZ5ZVNCdGRXTm9Mand2WkdsMgpQanhrYVhZK1BHSnlQand=
2
WkdsMlBqeGthWFkrUW1WemRDQnlaV2RoY21SekxEd3ZaR2wyUGp4a2FYWStVblZwUEM5a2FYWSs=
i
IHN0eWxlPSJtaW4taGVpZ2h0OiAwcHg7IHdpZHRoOiAwcHg7IG1heC1oZWlnaHQ6IDBweDsgbWF=
4
LXdpZHRoOiAwcHg7IG92ZXJmbG93OiBoaWRkZW47IGZvbnQtc2l6ZTogMGVtOyBwYWRkaW5nOiA=
w
cHg7IG1hcmdpbjogMHB4OyI+4oCLPC9kaXY+PC9kaXY+PC9kaXY+PGJyPjxicj48L3NwYW4+PHB=
y
ZT5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188d2JyPl9fX19fX19fX19fX19fX19fCmx=
0
dG5nLWRldiBtYWlsaW5nIGxpc3QKPGEgaHJlZj0ibWFpbHRvOmx0dG5nLWRldkBsaXN0cy5sdHR=
u
Zy5vcmciIHRhcmdldD0iX2JsYW5rIj5sdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnPC9hPjxhIGh=
y
ZWY9Imh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5=
n
LWRldiIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6PHdicj4vL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYml=
u
Lzx3YnI+bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXY8L2E+PGJyPjwvcHJlPjwvYmxvY2txdW9=
0
ZT48c3BhbiBjbGFzcz0iIj48YnI+PHByZT4tLSAKSm9uYXRoYW4gUi4gSnVsaWVuCkVmZmljaW9=
z
PC9wcmU+PGJyPl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzx3YnI+X19fX19fX19fX19=
f
X19fX188YnI+bHR0bmctZGV2IG1haWxpbmcgbGlzdDxicj48YSBocmVmPSJtYWlsdG86bHR0bmc=
t
ZGV2QGxpc3RzLmx0dG5nLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmx0dG5nLWRldkBsaXN0cy5sdHR=
u
Zy5vcmc8L2E+PGJyPjxhIGhyZWY9Imh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWl=
s
bWFuL2xpc3RpbmZvL2x0dG5nLWRldiIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9saXN0cy5sdHR=
u
Zy5vcmcvY2dpLTx3YnI+YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2PC9hPjxicj48L3N=
w
YW4+PC9ibG9ja3F1b3RlPjxzcGFuIGNsYXNzPSIiPjxmb250IGNvbG9yPSIjODg4ODg4Ij48ZGl=
2
Pjxicj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4tLSA8YnI+PC9kaXY+PGRpdj48c3B=
h
biBuYW1lPSJ4Ij48L3NwYW4+TWF0aGlldSBEZXNub3llcnM8YnI+RWZmaWNpT1MgSW5jLjxicj4=
8
YSBocmVmPSJodHRwOi8vd3d3LmVmZmljaW9zLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9=
3
d3cuZWZmaWNpb3MuY29tPC9hPjxzcGFuIG5hbWU9IngiPjwvc3Bhbj48YnI+PC9kaXY+PC9mb25=
0
Pjwvc3Bhbj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PC9kaXY+" style=
=3D"height:0;width:0;max-height:0;max-width:0;overflow:hidden;font-size:0em=
;padding:0;margin:0">=E2=80=8B</div></div></div>

--001a113fd7b2ee1b200511f52064--


--===============1218072980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1218072980==--
