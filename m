From: Shariyar <syed.shariyar@gmail.com>
Subject: Re: liblttng-ust-cyg-profile.so not found
Date: Tue, 28 Jan 2014 17:25:26 -0500
Message-ID: <CAKQh6pjsBv_ZO7TPZLUuW=3p_AM+Luqi-tCOQAq3eR+LZOR4Kg__14867.6587887623$1390947991$gmane$org@mail.gmail.com>
References: <CAKQh6pgjuidy=KzKNQx1hropC_A8Nvdsk4AX2S0j2CHXCP8ihw@mail.gmail.com>
	<1390930183.52e7e90758145@www.imp.polymtl.ca>
	<CAKQh6pgwetoHcw3fxRHqHcvEZOVcYFmia_xivgAH+YPO3ZxzkA@mail.gmail.com>
	<52E7ECBE.8050300@voxpopuli.im>
	<CAKQh6phn84uoHbEhjkY-m=FQrahTNDOfYA0zLJvpn+C=6QpDsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0611204332=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <syed.shariyar@gmail.com>) id 1W8H64-0006ky-Fm
	for lttng-dev@lists.lttng.org; Tue, 28 Jan 2014 17:25:38 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp16so941718pbb.34
	for <lttng-dev@lists.lttng.org>; Tue, 28 Jan 2014 14:25:26 -0800 (PST)
In-Reply-To: <CAKQh6phn84uoHbEhjkY-m=FQrahTNDOfYA0zLJvpn+C=6QpDsw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0611204332==
Content-Type: multipart/alternative; boundary=047d7b6786140ec28204f10f4dc7

--047d7b6786140ec28204f10f4dc7
Content-Type: text/plain; charset=ISO-8859-1

Okay. I have found the solution: I used another Debain repository to
download and install all the packages.

I am wondering, is there any tool/script that matches function addresses
with the symbol names from nm, and generates a new CTF file?

Regards,
Shariyar


On Tue, Jan 28, 2014 at 4:19 PM, Shariyar <syed.shariyar@gmail.com> wrote:

>
>  dpkg -L liblttng-ust0 gives the following; i.e., no
> liblttng-ust-cyg-profile.so
>
> /.
> /usr
> /usr/share
> /usr/share/doc
> /usr/share/doc/liblttng-ust0
> /usr/share/doc/liblttng-ust0/changelog.gz
> /usr/share/doc/liblttng-ust0/copyright
> /usr/share/man
> /usr/share/man/man3
> /usr/share/man/man3/lttng-ust.3.gz
> /usr/share/man/man3/lttng-ust-cyg-profile.3.gz
> /usr/lib
> /usr/lib/x86_64-linux-gnu
> /usr/lib/x86_64-linux-gnu/liblttng-ust-tracepoint.so.0.0.0
> /usr/lib/x86_64-linux-gnu/liblttng-ust-fork.so.0.0.0
> /usr/lib/x86_64-linux-gnu/liblttng-ust.so.0.0.0
> /usr/lib/x86_64-linux-gnu/liblttng-ust-libc-wrapper.so.0.0.0
> /usr/lib/x86_64-linux-gnu/liblttng-ust-ctl.so.2.0.0
> /usr/lib/x86_64-linux-gnu/liblttng-ust.so.0
> /usr/lib/x86_64-linux-gnu/liblttng-ust-tracepoint.so.0
> /usr/lib/x86_64-linux-gnu/liblttng-ust-libc-wrapper.so.0
> /usr/lib/x86_64-linux-gnu/liblttng-ust-fork.so.0
> /usr/lib/x86_64-linux-gnu/liblttng-ust-ctl.so.2
>
>
>
> On Tue, Jan 28, 2014 at 12:45 PM, Alexandre Montplaisir <
> alexmonthy@voxpopuli.im> wrote:
>
>> On Ubuntu/Debian, there is no "lib64", it's /usr/lib/x86_64-linux-gnu/
>>
>> If you installed UST from the distro package, it should be at:
>> /usr/lib/x86_64-linux-gnu/liblttng-ust-cyg-profile.so.0
>>
>> (the .so symlink is only installed by the -dev package)
>>
>> If you installed from source, it would be at:
>> /usr/local/lib/liblttng-ust-cyg-profile.so
>>
>>
>> Quick tip: you can use:
>>  dpkg -L liblttng-ust0
>> to list the files installed by a package.
>>
>>
>> Cheers,
>> Alexandre
>>
>>
>> On 14-01-28 12:32 PM, Shariyar wrote:
>> > It is not present in the system even after reinstalling ust libs from
>> PPA.
>> > I am working on Ubuntu 12.04.1 LTS, 64 bit.
>> >
>> > Regards,
>> > Shariyar
>> >
>> >
>> > On Tue, Jan 28, 2014 at 12:29 PM, Suchakrapani Datt Sharma <
>> > suchakrapani.sharma@polymtl.ca> wrote:
>> >
>> >> Check if the liblttng-ust-cyg-profile.so is present in system using
>> >> 'locate'. On
>> >> my system its in /usr/lib64
>> >>
>> >> Then give the absolute path -
>> >>
>> >> *LD_PRELOAD=/usr/lib64/liblttng-ust-cyg-profile.so* appname
>> >>
>> >> This works for me.
>> >>
>> >> --
>> >> Suchakra
>> >>
>> >> Quoting Shariyar <syed.shariyar@gmail.com>:
>> >>
>> >>> Hi,
>> >>>
>> >>> I am trying to collect function entry and exit points in a trace. I
>>  have
>> >>> followed the instructions written on the following man page:
>> >>>
>> >>
>> http://manpages.ubuntu.com/manpages/trusty/man3/lttng-ust-cyg-profile.3.html
>> >> .
>> >>>
>> >>> In my system, UST tracepoint tracing  is working fine and I am able to
>> >>> collect traces with the statically typed tracepoints in the code.
>> >> However,
>> >>> there is no liblttng-ust-cyg-profile.so in my system and I get an
>> error
>> >>> when I execute the following:
>> >>>
>> >>>        *LD_PRELOAD=liblttng-ust-cyg-profile.so* appname
>> >>>
>> >>> Please let me know how to get it to work?
>> >>>
>> >>> Thanks,
>> >>> Shariyar
>> >>>
>> >>
>> >>
>> >
>> >
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>

--047d7b6786140ec28204f10f4dc7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Okay. I have found the solution: I used another =
Debain repository to download and install all the packages.<br></div><br>I =
am wondering, is there any tool/script that matches function addresses with=
 the symbol names from nm, and generates a new CTF file?<br>
<br></div>Regards,<br>Shariyar<br></div><div class=3D"gmail_extra"><br><br>=
<div class=3D"gmail_quote">On Tue, Jan 28, 2014 at 4:19 PM, Shariyar <span =
dir=3D"ltr">&lt;<a href=3D"mailto:syed.shariyar@gmail.com" target=3D"_blank=
">syed.shariyar@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><br>=A0dpkg -L liblttng-ust=
0 gives the following; i.e., no liblttng-ust-cyg-profile.so<br><br>/.<br>/u=
sr<br>
/usr/share<br>/usr/share/doc<br>/usr/share/doc/liblttng-ust0<br>/usr/share/=
doc/liblttng-ust0/changelog.gz<br>
/usr/share/doc/liblttng-ust0/copyright<br>/usr/share/man<br>/usr/share/man/=
man3<br>/usr/share/man/man3/lttng-ust.3.gz<br>/usr/share/man/man3/lttng-ust=
-cyg-profile.3.gz<br>/usr/lib<br>/usr/lib/x86_64-linux-gnu<br>/usr/lib/x86_=
64-linux-gnu/liblttng-ust-tracepoint.so.0.0.0<br>

/usr/lib/x86_64-linux-gnu/liblttng-ust-fork.so.0.0.0<br>/usr/lib/x86_64-lin=
ux-gnu/liblttng-ust.so.0.0.0<br>/usr/lib/x86_64-linux-gnu/liblttng-ust-libc=
-wrapper.so.0.0.0<br>/usr/lib/x86_64-linux-gnu/liblttng-ust-ctl.so.2.0.0<br=
>

/usr/lib/x86_64-linux-gnu/liblttng-ust.so.0<br>/usr/lib/x86_64-linux-gnu/li=
blttng-ust-tracepoint.so.0<br>/usr/lib/x86_64-linux-gnu/liblttng-ust-libc-w=
rapper.so.0<br>/usr/lib/x86_64-linux-gnu/liblttng-ust-fork.so.0<br>/usr/lib=
/x86_64-linux-gnu/liblttng-ust-ctl.so.2<br>

<br></div><div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_extra=
"><br><br><div class=3D"gmail_quote">On Tue, Jan 28, 2014 at 12:45 PM, Alex=
andre Montplaisir <span dir=3D"ltr">&lt;<a href=3D"mailto:alexmonthy@voxpop=
uli.im" target=3D"_blank">alexmonthy@voxpopuli.im</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On Ubuntu/Debian, there is no &quot;lib64&qu=
ot;, it&#39;s /usr/lib/x86_64-linux-gnu/<br>
<br>
If you installed UST from the distro package, it should be at:<br>
/usr/lib/x86_64-linux-gnu/liblttng-ust-cyg-profile.so.0<br>
<br>
(the .so symlink is only installed by the -dev package)<br>
<br>
If you installed from source, it would be at:<br>
/usr/local/lib/liblttng-ust-cyg-profile.so<br>
<br>
<br>
Quick tip: you can use:<br>
=A0dpkg -L liblttng-ust0<br>
to list the files installed by a package.<br>
<br>
<br>
Cheers,<br>
Alexandre<br>
<div><div><br>
<br>
On 14-01-28 12:32 PM, Shariyar wrote:<br>
&gt; It is not present in the system even after reinstalling ust libs from =
PPA.<br>
&gt; I am working on Ubuntu 12.04.1 LTS, 64 bit.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Shariyar<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Jan 28, 2014 at 12:29 PM, Suchakrapani Datt Sharma &lt;<br>
&gt; <a href=3D"mailto:suchakrapani.sharma@polymtl.ca" target=3D"_blank">su=
chakrapani.sharma@polymtl.ca</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; Check if the liblttng-ust-cyg-profile.so is present in system usin=
g<br>
&gt;&gt; &#39;locate&#39;. On<br>
&gt;&gt; my system its in /usr/lib64<br>
&gt;&gt;<br>
&gt;&gt; Then give the absolute path -<br>
&gt;&gt;<br>
&gt;&gt; *LD_PRELOAD=3D/usr/lib64/liblttng-ust-cyg-profile.so* appname<br>
&gt;&gt;<br>
&gt;&gt; This works for me.<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Suchakra<br>
&gt;&gt;<br>
&gt;&gt; Quoting Shariyar &lt;<a href=3D"mailto:syed.shariyar@gmail.com" ta=
rget=3D"_blank">syed.shariyar@gmail.com</a>&gt;:<br>
&gt;&gt;<br>
&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I am trying to collect function entry and exit points in a tra=
ce. I =A0have<br>
&gt;&gt;&gt; followed the instructions written on the following man page:<b=
r>
&gt;&gt;&gt;<br>
&gt;&gt; <a href=3D"http://manpages.ubuntu.com/manpages/trusty/man3/lttng-u=
st-cyg-profile.3.html" target=3D"_blank">http://manpages.ubuntu.com/manpage=
s/trusty/man3/lttng-ust-cyg-profile.3.html</a><br>
&gt;&gt; .<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; In my system, UST tracepoint tracing =A0is working fine and I =
am able to<br>
&gt;&gt;&gt; collect traces with the statically typed tracepoints in the co=
de.<br>
&gt;&gt; However,<br>
&gt;&gt;&gt; there is no liblttng-ust-cyg-profile.so in my system and I get=
 an error<br>
&gt;&gt;&gt; when I execute the following:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =A0 =A0 =A0 =A0*LD_PRELOAD=3Dliblttng-ust-cyg-profile.so* appn=
ame<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Please let me know how to get it to work?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt; Shariyar<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
<br>
</blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--047d7b6786140ec28204f10f4dc7--


--===============0611204332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0611204332==--
