From: "Ionut D." <ionut5001@gmail.com>
Subject: Re: LTTNG on Android ICS
Date: Sat, 18 May 2013 10:21:52 +0300
Message-ID: <CAGNqz8L5oWTzq_g4McOWoU4e3TMpJnYDpD_5v9M1oQQaCSzCCA__34184.7193929881$1368861758$gmane$org@mail.gmail.com>
References: <CAGNqz8L+Kat-C+3RLRknPHOiGXX8_1zYcKCm1j1s5tet3AsEqA@mail.gmail.com>
	<CA+umk=qVWLKUymH9pvY9vSg_Hjf0Ynn1ccP+jyPYjtfvb3H2bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0278899982=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <ionut5001@gmail.com>) id 1UdbSn-00039s-No
	for lttng-dev@lists.lttng.org; Sat, 18 May 2013 03:21:57 -0400
Received: by mail-vb0-f50.google.com with SMTP id w16so60752vbb.23
	for <lttng-dev@lists.lttng.org>; Sat, 18 May 2013 00:21:52 -0700 (PDT)
In-Reply-To: <CA+umk=qVWLKUymH9pvY9vSg_Hjf0Ynn1ccP+jyPYjtfvb3H2bg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0278899982==
Content-Type: multipart/alternative; boundary=bcaec53aecea1acf9d04dcf8f421

--bcaec53aecea1acf9d04dcf8f421
Content-Type: text/plain; charset=ISO-8859-1

Great informations! I will post back the results.


On Fri, May 17, 2013 at 4:47 PM, Pierre-Luc St-Charles <
pierre-luc.st-charles@polymtl.ca> wrote:

> Alright, small update for all following a quick (non-mailing-list)
> exchange:
>
> We did successfully complete a kernel-tracing port of LTTng for Android
> (somewhat old news), but we are still working on bringing our patches back
> up to date with the current version of the different projects (soon-ish
> still applies here, we're talking days). So far, we dwelled a little bit in
> LTTng-UST, but haven't done much changes, so userspace tracing is still not
> functional. Device that ran kernel traces successfully so far were the
> Nexus S and the Nexus 7 (example Nexus S trace available here<https://drive.google.com/folderview?id=0B55Ba7lWTLh4U0hGeTQ4bmRYRjQ&usp=sharing>;
> still not perfect).
>
> Basically, we cross-compiled everything via the Android NDK (no Android
> makefiles involved here), and pushed all required bins to a device without
> having to flash it (unless the default kernel config didn't allow tracing
> -- then we'd have to flash). This approach is not compatible with the
> official Android build system (meaning we wouldn't be able to add it to
> Android like this), but we might eventually get working on the damned
> Android makefiles (they're extremely painful to write, especially since
> LTTng uses Autotools).
>
> The librairies required by LTTng that are not already included in a
> regular Android build (uuid/popt) can actually be found/compiled from the
> official repo, in its 'external' directory (see oprofile and e2fsprog --
> from memory). That might not be the easiest way to get them (full repo
> download is BIG), but compatibility is assured, and you can skip a full
> build by simply making those two individually for your device (if that's
> all you need).
>
> You'll also need your device to be rooted to use LTTng at all; then, most
> initializations are done via scripts (we'll also provide those with our
> patches). We still had some trouble automating everything via daemons, so
> we always ran the sessiond locally (with success).
>
> Major problems we encountered so far were missing posix functions, and
> sysv shared memory. Basically, Android relies on Bionic for its system
> calls and other low-level functions, and since Bionic is pretty
> 'lightweight', they trimmed most of the fat out for performance. We had to
> make some more-or-less sketchy replacements here and there, but everything
> seems to be working decently now.
>
> So, simple 'how do I put LTTng on Android' workflow would be this:
>
>   - Compile modules (using NDK) against device's kernel, making sure its
> config is appropriate, ship them over via ADB
>
>   - Compile required external libraries (using repo build system) for the
> device, ship them over via ADB
>
>   - Patch up LTTng-* (soon-ish! I could send you the outdated patches
> right now if you're interested though, they might be a month behind or so
> on the current trunks)
>
>   - Cross-compile LTTng-* for the device (using NDK), ship binaries over
> via ADB
>
> Then, on the device, start up the sessiond manually & start tracing.
>
>
> I think I went over everything, but if there's a part that's still cloudy,
> don't hesitate.
>
>
> -PL
>
>
> On May 17, 2013 1:32 AM, "Ionut D." <ionut5001@gmail.com> wrote:
>
>> Hello all,
>>
>> Recently I started to integrate LTTNG in Android ICS by compiling each
>> package, each dependency, by using the Android build system. It is a lot of
>> work because I met different problems and to be sincere, I do not know if
>> at the end will work and I do not know how much I will need to modify the
>> sources in order to work.
>>
>> My questions are about this integration. I mention that I read a lot of
>> discussions about this on Internet, on this mailing list, but the things
>> are still not very clear for me.
>>
>> It is ok? what I am trying to do ? to integrate and build by using the
>> Android build system.
>> Could you give me some guidelines, indications about how I should
>> proceed, maybe a tutorial or maybe some android make files/patches that
>> would help me to see how the job must be done and if I am doing it right ?
>>
>> Until now I managed to build lttng-modules, liburcu, libuuid from
>> util-linux and configure lttng-ust by using the android toolchain for arm.
>> I got a lot of errors but until now I managed to configure/make these
>> packages.
>>
>> I mention that I am trying to build lttng 2.x on ICS 4.0.3.
>>
>> Would be great if you will give me a tutorial about how to do it.
>>
>> Ionut
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>

--bcaec53aecea1acf9d04dcf8f421
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Great informations! I will post back the results.</div><di=
v class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri, May 17, =
2013 at 4:47 PM, Pierre-Luc St-Charles <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:pierre-luc.st-charles@polymtl.ca" target=3D"_blank">pierre-luc.st-charl=
es@polymtl.ca</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><p dir=3D"ltr">Alright, sma=
ll update for all following a quick (non-mailing-list) exchange:</p>
<p dir=3D"ltr">We did successfully complete a kernel-tracing port of LTTng =
for Android (somewhat old news), but we are still working on bringing our p=
atches back up to date with the current version of the different projects (=
soon-ish still applies here, we&#39;re talking days). So far, we dwelled a =
little bit in LTTng-UST, but haven&#39;t done much changes, so userspace tr=
acing is still not functional. Device that ran kernel traces successfully s=
o far were the Nexus S and the Nexus 7 (example Nexus S trace available <a =
href=3D"https://drive.google.com/folderview?id=3D0B55Ba7lWTLh4U0hGeTQ4bmRYR=
jQ&amp;usp=3Dsharing" target=3D"_blank">here</a>; still not perfect).</p>




<p dir=3D"ltr">Basically, we cross-compiled everything via the Android NDK =
(no Android makefiles involved here), and pushed all required bins to a dev=
ice without having to flash it (unless the default kernel config didn&#39;t=
 allow tracing -- then we&#39;d have to flash). This approach is not compat=
ible with the official Android build system (meaning we wouldn&#39;t be abl=
e to add it to Android like this), but we might eventually get working on t=
he damned Android makefiles (they&#39;re extremely painful to write, especi=
ally since LTTng uses Autotools).</p>




<p dir=3D"ltr">The librairies required by LTTng that are not already includ=
ed in a regular Android build (uuid/popt) can actually be found/compiled fr=
om the official repo, in its &#39;external&#39; directory (see oprofile and=
 e2fsprog -- from memory). That might not be the easiest way to get them (f=
ull repo download is BIG), but compatibility is assured, and you can skip a=
 full build by simply making those two individually for your device (if tha=
t&#39;s all you need).</p>




<p dir=3D"ltr">You&#39;ll also need your device to be rooted to use LTTng a=
t all; then, most initializations are done via scripts (we&#39;ll also prov=
ide those with our patches). We still had some trouble automating everythin=
g via daemons, so we always ran the sessiond locally (with success).</p>

<p>Major problems we encountered so far were missing posix functions, and s=
ysv shared memory. Basically, Android relies on Bionic for its system calls=
 and other low-level functions, and since Bionic is pretty &#39;lightweight=
&#39;, they trimmed most of the fat out for performance. We had to make som=
e more-or-less sketchy replacements here and there, but everything seems to=
 be working decently now.</p>

<p>So, simple &#39;how do I put LTTng on Android&#39; workflow would be thi=
s:</p><p>=A0 - Compile modules=A0(using NDK)=A0against device&#39;s kernel,=
 making sure its config is appropriate, ship them over via ADB</p>
<p>=A0 - Compile required external libraries (using repo build system) for =
the device, ship them over via ADB</p><p>=A0 - Patch up LTTng-* (soon-ish! =
I could send you the outdated patches right now if you&#39;re interested th=
ough, they might be a month behind or so on the current trunks)</p>

<p>=A0 - Cross-compile LTTng-* for the device (using NDK), ship binaries ov=
er via ADB</p><p>Then, on the device, start up the sessiond manually &amp; =
start tracing.</p><p><br></p><p>I think I went over everything, but if ther=
e&#39;s a part that&#39;s still cloudy, don&#39;t hesitate.</p>

<p><br></p><p>-PL</p><p>=A0=A0</p>


<div class=3D"gmail_quote">On May 17, 2013 1:32 AM, &quot;Ionut D.&quot; &l=
t;<a href=3D"mailto:ionut5001@gmail.com" target=3D"_blank">ionut5001@gmail.=
com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color=
:rgb(204,204,204);border-left-style:solid;padding-left:1ex">



<div dir=3D"ltr"><div>Hello all,</div><div><br></div><div>Recently I starte=
d to integrate LTTNG in Android ICS by compiling each package, each depende=
ncy, by using the Android build system. It is a lot of work because I met d=
ifferent problems and to be sincere,  I do not know if at the end will work=
 and I do not know how much I will need to modify the sources in order to w=
ork.<br>




</div><br>My questions are about this integration. I mention that I read a =
lot of discussions about this on Internet, on this mailing list, but the th=
ings are still not very clear for me.<br><br>It is ok? what I am trying to =
do ? to integrate and build by using the Android build system.<br>




Could you give me some guidelines, indications about how I should proceed, =
maybe a tutorial or maybe some android make files/patches that would help m=
e to see how the job must be done and if I am doing it right ?<br><br>



Until now I managed to build lttng-modules, liburcu, libuuid from util-linu=
x and configure lttng-ust by using the android toolchain for arm. I got a l=
ot of errors but until now I managed to configure/make these packages.<br>




<br>I mention that I am trying to build lttng 2.x on ICS 4.0.3.<br><br><div=
>Would be great if you will give me a tutorial about how to do it.</div><di=
v><br></div><div>Ionut</div></div>
<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div>
</div>
</blockquote></div><br></div>

--bcaec53aecea1acf9d04dcf8f421--


--===============0278899982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0278899982==--
