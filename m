From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@gmail.com>
Subject: Re: LTTng 2.9 sessiond misbehaving
Date: Thu, 6 Oct 2016 08:29:39 -0400
Message-ID: <CA+jJMxt20vc_rVqr2MwpB1RtueJD9-B01CuhWMG-ThY6Upj0Rw__40153.8062877536$1475759140$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFDB7DF14FE@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <48CF5AC71E61DB46B70D0F388054EFFDB7DF1580@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8000971581896215479=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vk0-f44.google.com (mail-vk0-f44.google.com
 [209.85.213.44])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 5F231A2E87
 for <lttng-dev@lists.lttng.org>; Thu,  6 Oct 2016 12:31:17 +0000 (UTC)
Received: by mail-vk0-f44.google.com with SMTP id b186so16039033vkb.1
 for <lttng-dev@lists.lttng.org>; Thu, 06 Oct 2016 05:29:41 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFDB7DF1580@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Daniel Thibault <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============8000971581896215479==
Content-Type: multipart/alternative; boundary=001a1141d9d2975cfb053e317274

--001a1141d9d2975cfb053e317274
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Oct 5, 2016 3:52 PM, "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca=
>
wrote:
>
> Interesting.  Rebuilt the entire LTTng set with the stable-1.8 releases
(stable-0.9 for userspace-rcu) and I see the same behaviour:
> When I hit ctrl-c in the daemon's shell, it doesn't respond and the CPU
usage goes crazy (~90%).  Can't sudo kill it (or lttng-runas) either.
>
> What's strange is that if instead of:
>
> $ lttng-sessiond -vvv 2>&1 | tee lttng-sessiond.2.log
>
> I do:
>
> $ lttng-sessiond 2>&1 | tee lttng-sessiond.3.log
>
> Then ctrl-c terminates lttng-sessiond normally.
>
> Using just the first level of verbosity:
>
> $ lttng-sessiond -v 2>&1 | tee lttng-sessiond.4.log
>
> also misbehaves.  Somehow -v is responsible?
>
> At this point, should I open a bug?

I'm assuming you meant 2.8.
Open a bug and we'll try to reproduce it.

Does the problem occur with the other verbosity levels? (-vv, -vvv)

Thanks,
J=C3=A9r=C3=A9mie

>
> Daniel U. Thibault, M.Sc.=C2=B2
>
> Informaticien scientifique, CME-PSC, Centre de recherches de Valcartier
> Recherche et d=C3=A9veloppement pour la d=C3=A9fense Canada / Gouvernemen=
t du Canada
> daniel.thibault@drdc-rddc.gc.ca / T=C3=A9l: 418-844-4000x4245 T=C3=A9l=C3=
=A9c:
418-844-4538
> daniel.thibault@forces.gc.ca / T=C3=A9l: 418-844-4000x4245 T=C3=A9l=C3=A9=
c: 418-844-4538
>
> Computer Scientist, MCCS-SPC, Valcartier Research Centre
> Defence Research and Development Canada / Government of Canada
> daniel.thibault@drdc-rddc.gc.ca / Tel: 418-844-4000x4245 Fax: 418-844-453=
8
> daniel.thibault@forces.gc.ca / Tel: 418-844-4000x4245 Fax: 418-844-4538
>
> DRDC is an agency of the Department of National Defence / RDDC est une
agence du minist=C3=A8re de la D=C3=A9fense nationale
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--001a1141d9d2975cfb053e317274
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Oct 5, 2016 3:52 PM, &quot;Thibault, Daniel&quot; &lt;<a =
href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca">Daniel.Thibault@drdc-rddc.g=
c.ca</a>&gt; wrote:<br>
&gt;<br>
&gt; Interesting.=C2=A0 Rebuilt the entire LTTng set with the stable-1.8 re=
leases (stable-0.9 for userspace-rcu) and I see the same behaviour:<br>
&gt; When I hit ctrl-c in the daemon&#39;s shell, it doesn&#39;t respond an=
d the CPU usage goes crazy (~90%).=C2=A0 Can&#39;t sudo kill it (or lttng-r=
unas) either.<br>
&gt;<br>
&gt; What&#39;s strange is that if instead of:<br>
&gt;<br>
&gt; $ lttng-sessiond -vvv 2&gt;&amp;1 | tee lttng-sessiond.2.log<br>
&gt;<br>
&gt; I do:<br>
&gt;<br>
&gt; $ lttng-sessiond 2&gt;&amp;1 | tee lttng-sessiond.3.log<br>
&gt;<br>
&gt; Then ctrl-c terminates lttng-sessiond normally.<br>
&gt;<br>
&gt; Using just the first level of verbosity:<br>
&gt;<br>
&gt; $ lttng-sessiond -v 2&gt;&amp;1 | tee lttng-sessiond.4.log<br>
&gt;<br>
&gt; also misbehaves.=C2=A0 Somehow -v is responsible?<br>
&gt;<br>
&gt; At this point, should I open a bug?</p>
<p dir=3D"ltr">I&#39;m assuming you meant 2.8.<br>
Open a bug and we&#39;ll try to reproduce it.</p>
<p dir=3D"ltr">Does the problem occur with the other verbosity levels? (-vv=
, -vvv)</p>
<p dir=3D"ltr">Thanks,<br>
J=C3=A9r=C3=A9mie</p>
<p dir=3D"ltr">&gt;<br>
&gt; Daniel U. Thibault, M.Sc.=C2=B2<br>
&gt;<br>
&gt; Informaticien scientifique, CME-PSC, Centre de recherches de Valcartie=
r<br>
&gt; Recherche et d=C3=A9veloppement pour la d=C3=A9fense Canada / Gouverne=
ment du Canada<br>
&gt; <a href=3D"mailto:daniel.thibault@drdc-rddc.gc.ca">daniel.thibault@drd=
c-rddc.gc.ca</a> / T=C3=A9l: 418-844-4000x4245 T=C3=A9l=C3=A9c: 418-844-453=
8<br>
&gt; <a href=3D"mailto:daniel.thibault@forces.gc.ca">daniel.thibault@forces=
.gc.ca</a> / T=C3=A9l: 418-844-4000x4245 T=C3=A9l=C3=A9c: 418-844-4538<br>
&gt;<br>
&gt; Computer Scientist, MCCS-SPC, Valcartier Research Centre<br>
&gt; Defence Research and Development Canada=C2=A0/ Government of Canada<br=
>
&gt; <a href=3D"mailto:daniel.thibault@drdc-rddc.gc.ca">daniel.thibault@drd=
c-rddc.gc.ca</a> / Tel: 418-844-4000x4245 Fax: 418-844-4538<br>
&gt; <a href=3D"mailto:daniel.thibault@forces.gc.ca">daniel.thibault@forces=
.gc.ca</a> / Tel: 418-844-4000x4245 Fax: 418-844-4538<br>
&gt;<br>
&gt; DRDC is an agency of the Department of National Defence / RDDC est une=
 agence du minist=C3=A8re de la D=C3=A9fense nationale<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br></p>

--001a1141d9d2975cfb053e317274--

--===============8000971581896215479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8000971581896215479==--
