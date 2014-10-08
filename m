From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: sessiond and consumerd for 32 and 64 bit apps
Date: Thu, 9 Oct 2014 01:49:02 +0530
Message-ID: <CAM5kDqxEkE1hh39AF_Do=Sr+PKZ+zSVXQEYaasPUue5Fdd0k_w__23713.1301350475$1412799610$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD5A23A757@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <CAM5kDqwSE4960TeRDg8tJdV_q=7-_3YttR1A8YPwQQYcus5LXA@mail.gmail.com>
 <48CF5AC71E61DB46B70D0F388054EFFD5A23A89D@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0740707950=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1XbxhU-00011H-Vu
 for lttng-dev@lists.lttng.org; Wed, 08 Oct 2014 16:19:15 -0400
Received: by mail-wi0-f173.google.com with SMTP id fb4so11479915wid.6
 for <lttng-dev@lists.lttng.org>; Wed, 08 Oct 2014 13:19:03 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD5A23A89D@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0740707950==
Content-Type: multipart/alternative; boundary=001a11c24c44e641c30504ef0651

--001a11c24c44e641c30504ef0651
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Daniel,
Thanks for your reply.

Cant the consumerd32-libdiror or consumerd32-bindir be given at run time by
using onsumerd32-path, consumerd32-libdir or by setting env variables
LTTNG_CONSUMERD32_LIBDIR and LTTNG_CONSUMERD32_BIN (similarly for 64-bit)

Can it be changed at compile time?

Thanks,
Anand Neeli

On Wed, Oct 8, 2014 at 8:36 PM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

>   > Yes the problem looks to be with relay daemon. Tracing for 32-bit and
> 64-bit works fine when written to local storage.
>
> > Is there any known issue for this? or is there any work around for this=
.
>
> > I will update this thread with logs of relayd with -vvv option.
>
> >
>
> > Anand Neeli
>
>
>
>    I=E2=80=99ve just tested my 32+64-bit LTTng 2.3.0 installation with th=
e relay
> daemon and it works fine:
>
>
>
> $ sudo lttng create testing -U net://localhost
>
> $ sudo lttng enable-channel mychannel --userspace --buffers-pid
> --tracefile-size 8388608 --tracefile-count 8
>
> $ sudo lttng enable-event --channel mychannel --userspace --all
>
> $ sudo lttng start
>
> $ cd
> ~/Documents/lttng-ust-2.3.0-1-32bits/usr/src/lttng-ust-2.3.0/doc/examples=
/drdc
>
> $ ./sample_static
>
> $ LD_PRELOAD=3D/usr/local/lib32/liblttng-ust.so ./sample_static32
>
> $ sudo lttng destroy
>
> $ sudo ls ~/lttng-traces/$HOSTNAME
>
> testing-20141008-095516
>
>
>
>    (The LD_PRELOAD can be omitted if the sample_static32 is compiled with
> the =E2=80=98-Wl,-rpath,'/usr/local/lib32',--enable-new-dtags=E2=80=99 li=
nker flags)
>
>
>
>    The trace consists of the two folder sets
> ust/pid/sample_static32-13703-20141008-102156 and
> ust/pid/sample_static-13676-20141008-101417.
>
>
>
>    Here=E2=80=99s how this was built (I chose to put my 32-bit libraries =
in
> /usr/local/lib32):
>
>
>
> userspace-rcu-0.8.0-1.deb was deployed to
> ~/Documents/userspace-rcu-0.8.0-1-32bits
>
>
>
> In the usr/src/userspace-rcu-0.8.0 subdirectory:
>
>
>
> $ ./bootstrap
>
> $ ./configure --libdir=3D/usr/local/lib32 CFLAGS=3D-m32
>
> $ make
>
> $ sudo make install
>
> $ sudo ldconfig
>
>
>
> lttng-ust-2.3.0-1.deb was deployed to ~/Documents/lttng-ust-2.3.0-1-32bit=
s
>
>
>
> In the usr/src/lttng-ust-2.3.0 subdirectory:
>
>
>
> $ ./bootstrap
>
> $ ./configure --libdir=3D/usr/local/lib32 CFLAGS=3D-m32 \
>
>    LDFLAGS=3D-L/usr/local/lib32
>
> $ make
>
> $ sudo make install
>
> $ sudo ldconfig
>
>
>
> LDFLAGS allows the build to find the 32-bit userspace-rcu libraries it
> requires.
>
>
>
> lttng-tools-2.3.0-1.deb was deployed to
> ~/Documents/lttng-tools-2.3.0-1-32bits
>
>
>
> In the usr/src/lttng-tools-2.3.0 subdirectory:
>
>
>
> $ ./bootstrap
>
> $ ./configure --libdir=3D/usr/local/lib32 CFLAGS=3D-m32 \
>
>    LDFLAGS=3D-L/usr/local/lib32 --bindir=3D/usr/local/bin32 \
>
>    --with-consumerd-only \
>
>    --with-consumerd64-libdir=3D/usr/local/lib \
>
>    --with-consumerd64-bin=3D/usr/local/lib/lttng/libexec/lttng-consumerd
>
> $ make
>
> $ sudo make install
>
> $ sudo ldconfig
>
>
>
> The bindir option isn=E2=80=99t actually used by the compilation and is i=
ndicated
> here just for completeness.  The with-consumerd64-bin and
> with-consumerd64-libdir options ensure the 32-bit lttng-tools components
> find the 64-bit consumer daemon.  Normally, the with-consumerd-only make
> fails because it tries to make too many tests; this was fixed by editing
> the Makefile and removing the tests sub-directory from the SUBDIRS variab=
le
> (line 305) before running configure.  The suppressed tests are not requir=
ed
> in order to have a functioning 32-bit LTTng toolchain.
>
>
>
> Finally, the 64-bit lttng-tools are redone to hook in the 32-bit
> lttng-consumerd.
>
>
>
> lttng-tools-2.3.0-1.deb was deployed to
> ~/Documents/lttng-tools-2.3.0-1-64bits
>
>
>
> In the usr/src/lttng-tools-2.3.0 subdirectory:
>
>
>
> $ ./bootstrap
>
> $ ./configure LDFLAGS=3D-L/usr/local/lib \
>
>    --with-consumerd32-libdir=3D/usr/local/lib32 \
>
>    --with-consumerd32-bin=3D/usr/local/lib32/lttng/libexec/lttng-consumer=
d
>
> $ make
>
> $ sudo make install
>
> $ sudo ldconfig
>
>
>
> This way, the lttng-sessiond and lttng-relayd daemons will automatically
> find and use the 32-bit lttng-consumerd if required.  No special flags ne=
ed
> to be added when controlling the daemons.
>
>
> Daniel U. Thibault
> Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection =
&
> Countermeasures (SPC)
> Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission C=
ritical
> Cyber Security (MCCS)
> RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research
> Centre
> 2459 route de la Bravoure
> Qu=C3=A9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ
> <http://--ESFSECEV-TY3011-------------------------------->>
> Gouvernement du Canada | Government of Canada <
> http://www.valcartier.drdc-rddc.gc.ca/
> <http://--ESFSECEV-TY3011--------------------->>
>

--001a11c24c44e641c30504ef0651
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Daniel,<br>Thanks for your reply.<br><br><div>Cant the con=
sumerd32-libdiror or consumerd32-bindir be given at run time by using onsum=
erd32-path, consumerd32-libdir or by setting env variables LTTNG_CONSUMERD3=
2_LIBDIR and LTTNG_CONSUMERD32_BIN (similarly for 64-bit)<br><br>Can it be =
changed at compile time?=C2=A0<br><br>Thanks,<br>Anand Neeli















</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On We=
d, Oct 8, 2014 at 8:36 PM, Thibault, Daniel <span dir=3D"ltr">&lt;<a href=
=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" target=3D"_blank">Daniel.Thibau=
lt@drdc-rddc.gc.ca</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">





<div lang=3D"FR-CA" link=3D"blue" vlink=3D"purple">
<div>
<div><span class=3D"">
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&gt; </=
span><span lang=3D"EN-CA">Yes the problem looks to be with relay daemon.
</span>Tracing for 32-bit and 64-bit works fine when written to local stora=
ge.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&gt; </=
span><span lang=3D"EN-CA">Is there any known issue for this? or is there an=
y work around for this.<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&gt; </=
span><span lang=3D"EN-CA">I will update this thread with logs of relayd wit=
h -vvv option.<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#1f497d">&gt;</span><u></u>=C2=
=A0<u></u></p>
</div>
</span><div>
<p class=3D"MsoNormal"><span style=3D"color:#1f497d">&gt; </span>Anand Neel=
i<span style=3D"color:#1f497d"><u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=A0<u></u></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">=C2=A0=C2=
=A0 I=E2=80=99ve just tested my 32+64-bit LTTng 2.3.0 installation with the=
 relay daemon and it works fine:<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ sudo ltt=
ng create testing -U net://localhost<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ sudo ltt=
ng enable-channel mychannel --userspace --buffers-pid --tracefile-size 8388=
608 --tracefile-count 8<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ sudo ltt=
ng enable-event --channel mychannel --userspace --all<u></u><u></u></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ sudo ltt=
ng start<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ cd ~/Doc=
uments/lttng-ust-2.3.0-1-32bits/usr/src/lttng-ust-2.3.0/doc/examples/drdc<u=
></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ ./sample=
_static<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ LD_PRELO=
AD=3D/usr/local/lib32/liblttng-ust.so ./sample_static32<u></u><u></u></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ sudo ltt=
ng destroy<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ sudo ls =
~/lttng-traces/$HOSTNAME<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">testing-20=
141008-095516<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">=C2=A0=C2=
=A0 (The LD_PRELOAD can be omitted if the sample_static32 is compiled with =
the =E2=80=98-Wl,-rpath,&#39;/usr/local/lib32&#39;,--enable-new-dtags=E2=80=
=99 linker flags)<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">=C2=A0=C2=
=A0 The trace consists of the two folder sets ust/pid/sample_static32-13703=
-20141008-102156 and ust/pid/sample_static-13676-20141008-101417.<u></u><u>=
</u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">=C2=A0=C2=
=A0 Here=E2=80=99s how this was built (I chose to put my 32-bit libraries i=
n /usr/local/lib32):<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">userspace-=
rcu-0.8.0-1.deb was deployed to ~/Documents/userspace-rcu-0.8.0-1-32bits<u>=
</u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">In the usr=
/src/userspace-rcu-0.8.0 subdirectory:<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ ./bootst=
rap<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ ./config=
ure --libdir=3D/usr/local/lib32 CFLAGS=3D-m32<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ make<u><=
/u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ sudo mak=
e install<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ sudo ldc=
onfig<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">lttng-ust-=
2.3.0-1.deb was deployed to ~/Documents/lttng-ust-2.3.0-1-32bits<u></u><u><=
/u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">In the usr=
/src/lttng-ust-2.3.0 subdirectory:<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ ./bootst=
rap<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ ./config=
ure --libdir=3D/usr/local/lib32 CFLAGS=3D-m32 \<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">=C2=A0=C2=
=A0 LDFLAGS=3D-L/usr/local/lib32<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ make<u><=
/u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ sudo mak=
e install<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ sudo ldc=
onfig<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">LDFLAGS al=
lows the build to find the 32-bit userspace-rcu libraries it requires.<u></=
u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">lttng-tool=
s-2.3.0-1.deb was deployed to ~/Documents/lttng-tools-2.3.0-1-32bits<u></u>=
<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">In the usr=
/src/lttng-tools-2.3.0 subdirectory:<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ ./bootst=
rap<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ ./config=
ure --libdir=3D/usr/local/lib32 CFLAGS=3D-m32 \<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">=C2=A0=C2=
=A0 LDFLAGS=3D-L/usr/local/lib32 --bindir=3D/usr/local/bin32 \<u></u><u></u=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">=C2=A0=C2=
=A0 --with-consumerd-only \<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">=C2=A0=C2=
=A0 --with-consumerd64-libdir=3D/usr/local/lib \<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">=C2=A0=C2=
=A0 --with-consumerd64-bin=3D/usr/local/lib/lttng/libexec/lttng-consumerd<u=
></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ make<u><=
/u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ sudo mak=
e install<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ sudo ldc=
onfig<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">The bindir=
 option isn=E2=80=99t actually used by the compilation and is indicated her=
e just for completeness.=C2=A0 The with-consumerd64-bin and with-consumerd6=
4-libdir
 options ensure the 32-bit lttng-tools components find the 64-bit consumer =
daemon.=C2=A0 Normally, the with-consumerd-only make fails because it tries=
 to make too many tests; this was fixed by editing the Makefile and removin=
g the tests sub-directory from the SUBDIRS
 variable (line 305) before running configure.=C2=A0 The suppressed tests a=
re not required in order to have a functioning 32-bit LTTng toolchain.<u></=
u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">Finally, t=
he 64-bit lttng-tools are redone to hook in the 32-bit lttng-consumerd.<u><=
/u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">lttng-tool=
s-2.3.0-1.deb was deployed to ~/Documents/lttng-tools-2.3.0-1-64bits<u></u>=
<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">In the usr=
/src/lttng-tools-2.3.0 subdirectory:<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ ./bootst=
rap<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ ./config=
ure LDFLAGS=3D-L/usr/local/lib \<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">=C2=A0=C2=
=A0 --with-consumerd32-libdir=3D/usr/local/lib32 \<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">=C2=A0=C2=
=A0 --with-consumerd32-bin=3D/usr/local/lib32/lttng/libexec/lttng-consumerd=
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ make<u><=
/u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ sudo mak=
e install<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">$ sudo ldc=
onfig<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=
=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">This way, =
the lttng-sessiond and lttng-relayd daemons will automatically find and use=
 the 32-bit lttng-consumerd if required.=C2=A0 No special flags
 need to be added when controlling the daemons.<u></u><u></u></span></p>
</div>
</div><span class=3D"">
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><br>
</span>Daniel U. Thibault<br>
Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection &a=
mp; Countermeasures (SPC)<br>
Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission Cri=
tical Cyber Security (MCCS)<br>
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re<br>
2459 route de la Bravoure<br>
Qu=C3=A9bec QC=C2=A0 G3J 1X5<br>
CANADA<br>
Vox : (418) 844-4000 x4245<br>
Fax : (418) 844-4538<br>
NAC : 918V QSDJ &lt;<a href=3D"http://--ESFSECEV-TY3011--------------------=
------------" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918=
V%20QSDJ</a>&gt;<br>
Gouvernement du Canada | Government of Canada &lt;<a href=3D"http://--ESFSE=
CEV-TY3011---------------------" target=3D"_blank">http://www.valcartier.dr=
dc-rddc.gc.ca/</a>&gt;<span style=3D"color:#1f497d"><u></u><u></u></span></=
p>
</div>
</div>
</div>
</div>
</span></div>
</div>

</blockquote></div><br></div>

--001a11c24c44e641c30504ef0651--


--===============0740707950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0740707950==--
