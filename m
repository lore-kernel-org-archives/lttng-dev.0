From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: How to compile lttng-modules using full kernel
 source tree.
Date: Fri, 20 Mar 2015 10:36:36 -0400
Message-ID: <550C3074.2010409__25380.5149849088$1426862279$gmane$org@efficios.com>
References: <CABy43G9szQBY9eObtid3D0nDTBxm-50dSbT73MT-v_ac+4n9Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1451512495=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1YYy2X-0003CG-Ga
 for lttng-dev@lists.lttng.org; Fri, 20 Mar 2015 10:36:47 -0400
In-Reply-To: <CABy43G9szQBY9eObtid3D0nDTBxm-50dSbT73MT-v_ac+4n9Tw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Rui Han <iurnah@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============1451512495==
Content-Type: multipart/alternative;
 boundary="------------070706040406060806020108"

This is a multi-part message in MIME format.
--------------070706040406060806020108
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hey,
See comments below.

On 2015-03-20 09:34 AM, Rui Han wrote:
>
> Hi,
>
> I have encountered following output when I try to run make from the=20
> lttng-modules source cloned from git repo. I have tried in a clean=20
> install of both 12.04 and 14.04.
>
> |make -C /lib/modules/3.13.0-45-generic/build M=3D/home/troguard32/lttn=
g/lttng-modules modules
> make[1]: Entering directory `/usr/src/linux-headers-3.13.0-45-generic'
> /home/troguard32/lttng/lttng-modules/probes/Makefile:30: File /usr/src/=
linux-headers-3.13.0-45-generic/virt/kvm/iodev.h not found. Probe "kvm" x=
86-specific is disabled. Use full kernel source tree to enable it.
> /home/troguard32/lttng/lttng-modules/probes/Makefile:142: Files /usr/sr=
c/linux-headers-3.13.0-45-generic/fs/btrfs/*.h not found. Probe "btrfs" i=
s disabled. Use full kernel source tree to enable it.
> /home/troguard32/lttng/lttng-modules/probes/Makefile:158: Files /usr/sr=
c/linux-headers-3.13.0-45-generic/fs/ext4/*.h not found. Probe "ext4" is =
disabled. Use full kernel source tree to enable it.
>    Building modules, stage 2.
>    MODPOST 43 modules
> make[1]: Leaving directory `/usr/src/linux-headers-3.13.0-45-generic'
> |
>
> when run make modules_install, it seem the installation is successful,=20
> but the output is abnormal, giving repeated =E2=80=9CCan=E2=80=99t read=
 private key=E2=80=9D=20
> messages.
>
> If I ignore this message and install all other lttng components, it=20
> seems lttng kernel tracer is working fine.
>
> My question is,
>
>  1. How to completely remove this abnormal message? where to specify
>     the full kernel source path in make file? (I am a makefile beginner=
)
>
Abnormal message being the key related one? We are looking into but this=20
does not in any way change behavior.

As for the warning for kvm/btrfs/ext4. Nothing to worry about you simply=20
don't have these components installed on your system.
>
>  1. How to check whether the lttng-modules installed is fully
>     functional or not?
>
A quick check is the one you probably did: lttng list -k. You can also=20
run the root_regression tests from lttng-tools. Under ./tests you can=20
run ./run.sh root_regression while being root.
>
>  1. Does the above message is just telling me that I will be able to
>     use the full function of lttng-modules except those file system
>     probe mentioned in the make output?
>
Exactly.
>
> Thank you very much.
>
> Best regards,
> Rui
>
> =E2=80=8B
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Jonathan R. Julien
Efficios


--------------070706040406060806020108
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DISO-8859-1"
      http-equiv=3D"Content-Type">
  </head>
  <body>
    Hey,<br>
    See comments below.<br>
    <br>
    <div class=3D"moz-cite-prefix">On 2015-03-20 09:34 AM, Rui Han wrote:=
<br>
    </div>
    <blockquote
cite=3D"mid:CABy43G9szQBY9eObtid3D0nDTBxm-50dSbT73MT-v_ac+4n9Tw@mail.gmai=
l.com"
      type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"markdown-here-wrapper" style=3D"">
          <p style=3D"margin:1.2em 0px!important">Hi,</p>
          <p style=3D"margin:1.2em 0px!important">I have encountered
            following output when I try to run make from the
            lttng-modules source cloned from git repo. I have tried in a
            clean install of both 12.04 and 14.04.</p>
          <pre style=3D"font-size:0.85em;font-family:Consolas,Inconsolata=
,Courier,monospace;font-size:1em;line-height:1.2em;margin:1.2em 0px"><cod=
e style=3D"font-size:0.85em;font-family:Consolas,Inconsolata,Courier,mono=
space;margin:0px 0.15em;padding:0px 0.3em;white-space:pre-wrap;border:1px=
 solid rgb(234,234,234);border-radius:3px;display:inline;background-color=
:rgb(248,248,248);white-space:pre;overflow:auto;border-radius:3px;border:=
1px solid rgb(204,204,204);padding:0.5em 0.7em;display:block!important">m=
ake -C /lib/modules/3.13.0-45-generic/build M=3D/home/troguard32/lttng/lt=
tng-modules modules
make[1]: Entering directory `/usr/src/linux-headers-3.13.0-45-generic'
/home/troguard32/lttng/lttng-modules/probes/Makefile:30: File /usr/src/li=
nux-headers-3.13.0-45-generic/virt/kvm/iodev.h not found. Probe "kvm" x86=
-specific is disabled. Use full kernel source tree to enable it.
/home/troguard32/lttng/lttng-modules/probes/Makefile:142: Files /usr/src/=
linux-headers-3.13.0-45-generic/fs/btrfs/*.h not found. Probe "btrfs" is =
disabled. Use full kernel source tree to enable it.
/home/troguard32/lttng/lttng-modules/probes/Makefile:158: Files /usr/src/=
linux-headers-3.13.0-45-generic/fs/ext4/*.h not found. Probe "ext4" is di=
sabled. Use full kernel source tree to enable it.
  Building modules, stage 2.
  MODPOST 43 modules
make[1]: Leaving directory `/usr/src/linux-headers-3.13.0-45-generic'
</code></pre>
          <p style=3D"margin:1.2em 0px!important">when run make
            modules_install, it seem the installation is successful, but
            the output is abnormal, giving repeated =E2=80=9CCan=E2=80=99=
t read private
            key=E2=80=9D messages.</p>
          <p style=3D"margin:1.2em 0px!important">If I ignore this messag=
e
            and install all other lttng components, it seems lttng
            kernel tracer is working fine. </p>
          <p style=3D"margin:1.2em 0px!important">My question is,</p>
          <ol style=3D"margin:1.2em 0px;padding-left:2em">
            <li style=3D"margin:0.5em 0px">How to completely remove this
              abnormal message? where to specify the full kernel source
              path in make file? (I am a makefile beginner)</li>
          </ol>
        </div>
      </div>
    </blockquote>
    Abnormal message being the key related one? We are looking into but
    this does not in any way change behavior.<br>
    <br>
    As for the warning for kvm/btrfs/ext4. Nothing to worry about you
    simply don't have these components installed on your system.<br>
    <blockquote
cite=3D"mid:CABy43G9szQBY9eObtid3D0nDTBxm-50dSbT73MT-v_ac+4n9Tw@mail.gmai=
l.com"
      type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"markdown-here-wrapper" style=3D"">
          <ol style=3D"margin:1.2em 0px;padding-left:2em">
            <li style=3D"margin:0.5em 0px">How to check whether the
              lttng-modules installed is fully functional or not?</li>
          </ol>
        </div>
      </div>
    </blockquote>
    A quick check is the one you probably did: lttng list -k. You can
    also run the root_regression tests from lttng-tools. Under ./tests
    you can run ./run.sh root_regression while being root.<br>
    <blockquote
cite=3D"mid:CABy43G9szQBY9eObtid3D0nDTBxm-50dSbT73MT-v_ac+4n9Tw@mail.gmai=
l.com"
      type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"markdown-here-wrapper" style=3D"">
          <ol style=3D"margin:1.2em 0px;padding-left:2em">
            <li style=3D"margin:0.5em 0px">Does the above message is just
              telling me that I will be able to use the full function of
              lttng-modules except those file system probe mentioned in
              the make output? </li>
          </ol>
        </div>
      </div>
    </blockquote>
    Exactly. <br>
    <blockquote
cite=3D"mid:CABy43G9szQBY9eObtid3D0nDTBxm-50dSbT73MT-v_ac+4n9Tw@mail.gmai=
l.com"
      type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"markdown-here-wrapper" style=3D"">
          <ol style=3D"margin:1.2em 0px;padding-left:2em">
          </ol>
          <p style=3D"margin:1.2em 0px!important">Thank you very much.</p=
>
          <p style=3D"margin:1.2em 0px!important">Best regards,<br>
            Rui</p>
          <div
title=3D"MDH:SGksPGRpdj48YnI+PC9kaXY+PGRpdj5JIGhhdmUgZW5jb3VudGVyZWQgZm9s=
bG93aW5nIG91dHB1dCB3aGVuIEkgdHJ5IHRvIHJ1biBtYWtlIGZyb20gdGhlIGx0dG5nLW1vZ=
HVsZXMgc291cmNlIGNs
b25lZCBmcm9tIGdpdCByZXBvLiBJIGhhdmUgdHJpZWQgaW4gYSBjbGVhbiBpbnN0YWxsIG9mI=
GJv
dGggMTIuMDQgYW5kIDE0LjA0LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+YGBgPC9kaXY+P=
GRp
dj48ZGl2Pm1ha2UgLUMgL2xpYi9tb2R1bGVzLzMuMTMuMC00NS1nZW5lcmljL2J1aWxkIE09L=
2hv
bWUvdHJvZ3VhcmQzMi9sdHRuZy9sdHRuZy1tb2R1bGVzIG1vZHVsZXM8L2Rpdj48ZGl2Pm1ha=
2Vb
MV06IEVudGVyaW5nIGRpcmVjdG9yeSBgL3Vzci9zcmMvbGludXgtaGVhZGVycy0zLjEzLjAtN=
DUt
Z2VuZXJpYyc8L2Rpdj48ZGl2Pi9ob21lL3Ryb2d1YXJkMzIvbHR0bmcvbHR0bmctbW9kdWxlc=
y9w
cm9iZXMvTWFrZWZpbGU6MzA6IEZpbGUgL3Vzci9zcmMvbGludXgtaGVhZGVycy0zLjEzLjAtN=
DUt
Z2VuZXJpYy92aXJ0L2t2bS9pb2Rldi5oIG5vdCBmb3VuZC4gUHJvYmUgImt2bSIgeDg2LXNwZ=
WNp
ZmljIGlzIGRpc2FibGVkLiBVc2UgZnVsbCBrZXJuZWwgc291cmNlIHRyZWUgdG8gZW5hYmxlI=
Gl0
LjwvZGl2PjxkaXY+L2hvbWUvdHJvZ3VhcmQzMi9sdHRuZy9sdHRuZy1tb2R1bGVzL3Byb2Jlc=
y9N
YWtlZmlsZToxNDI6IEZpbGVzIC91c3Ivc3JjL2xpbnV4LWhlYWRlcnMtMy4xMy4wLTQ1LWdlb=
mVy
aWMvZnMvYnRyZnMvKi5oIG5vdCBmb3VuZC4gUHJvYmUgImJ0cmZzIiBpcyBkaXNhYmxlZC4gV=
XNl
IGZ1bGwga2VybmVsIHNvdXJjZSB0cmVlIHRvIGVuYWJsZSBpdC48L2Rpdj48ZGl2Pi9ob21lL=
3Ry
b2d1YXJkMzIvbHR0bmcvbHR0bmctbW9kdWxlcy9wcm9iZXMvTWFrZWZpbGU6MTU4OiBGaWxlc=
yAv
dXNyL3NyYy9saW51eC1oZWFkZXJzLTMuMTMuMC00NS1nZW5lcmljL2ZzL2V4dDQvKi5oIG5vd=
CBm
b3VuZC4gUHJvYmUgImV4dDQiIGlzIGRpc2FibGVkLiBVc2UgZnVsbCBrZXJuZWwgc291cmNlI=
HRy
ZWUgdG8gZW5hYmxlIGl0LjwvZGl2PjxkaXY+Jm5ic3A7IEJ1aWxkaW5nIG1vZHVsZXMsIHN0Y=
Wdl
IDIuPC9kaXY+PGRpdj4mbmJzcDsgTU9EUE9TVCA0MyBtb2R1bGVzPC9kaXY+PGRpdj5tYWtlW=
zFd
OiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Vzci9zcmMvbGludXgtaGVhZGVycy0zLjEzLjAtNDUtZ=
2Vu
ZXJpYyc8L2Rpdj48L2Rpdj48ZGl2PmBgYDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+d2hlb=
iBy
dW4gbWFrZSBtb2R1bGVzX2luc3RhbGwsIGl0IHNlZW0gdGhlIGluc3RhbGxhdGlvbiBpcyBzd=
WNj
ZXNzZnVsLCBidXQgdGhlIG91dHB1dCBpcyBhYm5vcm1hbCwgZ2l2aW5nIHJlcGVhdGVkICJDY=
W4n
dCByZWFkIHByaXZhdGUga2V5IiBtZXNzYWdlcy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2P=
klm
IEkgaWdub3JlIHRoaXMgbWVzc2FnZSBhbmQgaW5zdGFsbCBhbGwgb3RoZXIgbHR0bmcgY29tc=
G9u
ZW50cywgaXQgc2VlbXMgbHR0bmcga2VybmVsIHRyYWNlciBpcyB3b3JraW5nIGZpbmUuJm5ic=
3A7
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5NeSBxdWVzdGlvbiBpcyw8L2Rpdj48ZGl2PjEuI=
Ehv
dyB0byBjb21wbGV0ZWx5IHJlbW92ZSB0aGlzIGFibm9ybWFsIG1lc3NhZ2U/IHdoZXJlIHRvI=
HNw
ZWNpZnkgdGhlIGZ1bGwga2VybmVsIHNvdXJjZSBwYXRoIGluIG1ha2UgZmlsZT8gKEkgYW0gY=
SBt
YWtlZmlsZSBiZWdpbm5lcik8L2Rpdj48ZGl2PjIuIEhvdyB0byBjaGVjayB3aGV0aGVyIHRoZ=
SBs
dHRuZy1tb2R1bGVzIGluc3RhbGxlZCBpcyBmdWxseSBmdW5jdGlvbmFsIG9yIG5vdD88L2Rpd=
j48
ZGl2PjMuIERvZXMgdGhlIGFib3ZlIG1lc3NhZ2UgaXMganVzdCB0ZWxsaW5nIG1lIHRoYXQgS=
SB3
aWxsIGJlIGFibGUgdG8gdXNlIHRoZSBmdWxsIGZ1bmN0aW9uIG9mIGx0dG5nLW1vZHVsZXMgZ=
Xhj
ZXB0IHRob3NlIGZpbGUgc3lzdGVtIHByb2JlIG1lbnRpb25lZCBpbiB0aGUgbWFrZSBvdXRwd=
XQ/
Jm5ic3A7PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFuayB5b3UgdmVyeSBtdWNoLjwvZ=
Gl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+QmVzdCByZWdhcmRzLDwvZGl2PjxkaXY+UnVpPC9kaXY+"
style=3D"height:0;width:0;max-height:0;max-width:0;overflow:hidden;font-s=
ize:0em;padding:0;margin:0">=E2=80=8B</div>
        </div>
      </div>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
lttng-dev mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lttng-dev@lists.lttn=
g.org">lttng-dev@lists.lttng.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"http://lists.lttng.org/cgi-bin=
/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listi=
nfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Jonathan R. Julien
Efficios</pre>
  </body>
</html>

--------------070706040406060806020108--


--===============1451512495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1451512495==--
