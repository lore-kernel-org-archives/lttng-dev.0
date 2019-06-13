From: Zvi Vered <veredz72@gmail.com>
Subject: Re: (no subject)
Date: Thu, 13 Jun 2019 15:20:14 +0300
Message-ID: <CABRndgwEg3wYLbyfobjxdEKd8O1dAu+B+PwS-0A5gxURjKj_WA__34273.5788131662$1560428446$gmane$org@mail.gmail.com>
References: <CABRndgyzXQaYpefcMEMt1ShbqVKaf9vLJOXaL2cgUZMik4=xxw@mail.gmail.com>
 <CAB4xu_0h-q6En3_hDODbKuXd1=4_e0car73pP8Cf=LNWMKjh_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8913968098176976156=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw1-xc2b.google.com (mail-yw1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by lists.lttng.org (Postfix) with ESMTPS id 45PjVz4xXTz18jc
 for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2019 08:20:27 -0400 (EDT)
Received: by mail-yw1-xc2b.google.com with SMTP id v188so8225811ywb.13
 for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2019 05:20:27 -0700 (PDT)
In-Reply-To: <CAB4xu_0h-q6En3_hDODbKuXd1=4_e0car73pP8Cf=LNWMKjh_g@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8913968098176976156==
Content-Type: multipart/alternative; boundary="000000000000105abb058b338e54"

--000000000000105abb058b338e54
Content-Type: text/plain; charset="UTF-8"

Hi Phil,

Can you please estimate when version 2 will be released ?

Can you please provide sample code that uses Babeltrace to read metadata,
channel ?

Thank you for the tip. You saved us many hours of work.

Best regards,
Zvika

On Thu, Jun 13, 2019, 07:06 Philippe Proulx <eeppeliteloop@gmail.com> wrote:

> On Wed, Jun 12, 2019 at 11:22 PM Zvi Vered <veredz72@gmail.com> wrote:
> >
> > Hello,
> >
> > I'm trying to read the file "metadata".
> > I read the struct:
> >
> > struct metadata_packet_header {
> > uint32_t magic; /* 0x75D11D57 */
> > uint8_t  uuid[16]; /* Unique Universal Identifier */
> > uint32_t checksum; /* 0 if unused */
> > uint32_t content_size; /* in bits */
> > uint32_t packet_size; /* in bits */
> > uint8_t  compression_scheme; /* 0 if unused */
> > uint8_t  encryption_scheme; /* 0 if unused */
> > uint8_t  checksum_scheme; /* 0 if unused */
> > uint8_t  major; /* CTF spec major version number */
> > uint8_t  minor; /* CTF spec minor version number */
> > HEADER_END;
> > };
> >
> > the magic is indeed 0x75D11D57.
> > What is next struct I should read ?
> > I would expect "packet context". Am I right ?
> > what struct is it ?
> >
> > I want to write a simple babeltrace for windows.
>
> Not to discourage you, but I think you're only beginning a very long
> journey. Reading a CTF trace entails:
>
> 1. Depacketize the metadata stream to get the metadata text.
>
> 2. Parse the metadata text to get the appropriate trace, stream, clock,
>    and event classes. That's a custom, and somewhat complex,
>    domain-specific language called TSDL.
>
> 3. Use the classes found in 2. to decode each data stream. This involves
>    decoding integer fields with custom sizes (for example, a 27-bit
>    unsigned integer field), dynamically finding the lengths of
>    sequences and the selectors of variants, updating the stream's clock,
>    and much more.
>
> 4. Merge the events of the trace's data streams decoded in 3.  to get a
>    monotonic sequence of events.
>
> Add to this various fixes for known tracer bugs and support for features
> such as trace file rotation and tracing session rotation.
>
> Please don't attempt this.
>
> We are currently polishing the Babeltrace 2 project which does all that,
> and much more, for the Linux, macOS, and Windows platforms. Our goal is
> to offer a flexible, plugin-based framework to read, manipulate, and
> write traces in different formats.
>
> Phil
>
> > If I succeed, and you will find it relevant, I can upload this project.
> >
> > Thank you in advance,
> > Zvika
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--000000000000105abb058b338e54
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Phil,<div dir=3D"auto"><br></div><div dir=3D"auto">Can=
 you please estimate when version 2 will be released ?</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Can you please provide sample code that uses=
 Babeltrace to read metadata, channel ?</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Thank you for the tip. You saved us many hours of work.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Best regards,</div><div dir=
=3D"auto">Zvika</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jun 13, 2019, 07:06 Philippe Proulx &lt;<a hre=
f=3D"mailto:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">On Wed, Jun 12, 2019 at 11:22 PM Z=
vi Vered &lt;<a href=3D"mailto:veredz72@gmail.com" target=3D"_blank" rel=3D=
"noreferrer">veredz72@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hello,<br>
&gt;<br>
&gt; I&#39;m trying to read the file &quot;metadata&quot;.<br>
&gt; I read the struct:<br>
&gt;<br>
&gt; struct metadata_packet_header {<br>
&gt; uint32_t magic; /* 0x75D11D57 */<br>
&gt; uint8_t=C2=A0 uuid[16]; /* Unique Universal Identifier */<br>
&gt; uint32_t checksum; /* 0 if unused */<br>
&gt; uint32_t content_size; /* in bits */<br>
&gt; uint32_t packet_size; /* in bits */<br>
&gt; uint8_t=C2=A0 compression_scheme; /* 0 if unused */<br>
&gt; uint8_t=C2=A0 encryption_scheme; /* 0 if unused */<br>
&gt; uint8_t=C2=A0 checksum_scheme; /* 0 if unused */<br>
&gt; uint8_t=C2=A0 major; /* CTF spec major version number */<br>
&gt; uint8_t=C2=A0 minor; /* CTF spec minor version number */<br>
&gt; HEADER_END;<br>
&gt; };<br>
&gt;<br>
&gt; the magic is indeed 0x75D11D57.<br>
&gt; What is next struct I should read ?<br>
&gt; I would expect &quot;packet context&quot;. Am I right ?<br>
&gt; what struct is it ?<br>
&gt;<br>
&gt; I want to write a simple babeltrace for windows.<br>
<br>
Not to discourage you, but I think you&#39;re only beginning a very long<br=
>
journey. Reading a CTF trace entails:<br>
<br>
1. Depacketize the metadata stream to get the metadata text.<br>
<br>
2. Parse the metadata text to get the appropriate trace, stream, clock,<br>
=C2=A0 =C2=A0and event classes. That&#39;s a custom, and somewhat complex,<=
br>
=C2=A0 =C2=A0domain-specific language called TSDL.<br>
<br>
3. Use the classes found in 2. to decode each data stream. This involves<br=
>
=C2=A0 =C2=A0decoding integer fields with custom sizes (for example, a 27-b=
it<br>
=C2=A0 =C2=A0unsigned integer field), dynamically finding the lengths of<br=
>
=C2=A0 =C2=A0sequences and the selectors of variants, updating the stream&#=
39;s clock,<br>
=C2=A0 =C2=A0and much more.<br>
<br>
4. Merge the events of the trace&#39;s data streams decoded in 3.=C2=A0 to =
get a<br>
=C2=A0 =C2=A0monotonic sequence of events.<br>
<br>
Add to this various fixes for known tracer bugs and support for features<br=
>
such as trace file rotation and tracing session rotation.<br>
<br>
Please don&#39;t attempt this.<br>
<br>
We are currently polishing the Babeltrace 2 project which does all that,<br=
>
and much more, for the Linux, macOS, and Windows platforms. Our goal is<br>
to offer a flexible, plugin-based framework to read, manipulate, and<br>
write traces in different formats.<br>
<br>
Phil<br>
<br>
&gt; If I succeed, and you will find it relevant, I can upload this project=
.<br>
&gt;<br>
&gt; Thank you in advance,<br>
&gt; Zvika<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank" rel=3D"=
noreferrer">lttng-dev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.lttng.org/cg=
i-bin/mailman/listinfo/lttng-dev</a><br>
</blockquote></div>

--000000000000105abb058b338e54--

--===============8913968098176976156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8913968098176976156==--
