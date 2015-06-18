From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Test: mi: test for greater or
 equal to a minimum of events on ust listing.
Date: Thu, 18 Jun 2015 11:17:22 -0400
Message-ID: <CA+jJMxudAA3GHNFdhuAUsrmOUvsNX=uekBbO2qY8yuUwNCfHnA__12917.1353568838$1434640727$gmane$org@mail.gmail.com>
References: <1433950061-27364-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <579469314.862.1434637120162.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0116407744=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Z5bZI-0003x9-KM
 for lttng-dev@lists.lttng.org; Thu, 18 Jun 2015 11:17:36 -0400
Received: by pacyx8 with SMTP id yx8so63540286pac.2
 for <lttng-dev@lists.lttng.org>; Thu, 18 Jun 2015 08:17:23 -0700 (PDT)
In-Reply-To: <579469314.862.1434637120162.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============0116407744==
Content-Type: multipart/alternative; boundary=001a11c1dc94e673ee0518cc4d9b

--001a11c1dc94e673ee0518cc4d9b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged, thanks!

J=C3=A9r=C3=A9mie

On Thu, Jun 18, 2015 at 10:18 AM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> bump: J=C3=A9r=C3=A9mie, I know you are busy with Babeltrace, but can you=
 quickly
> look into merging this fix ? It would repair the CI.
>
> Thanks,
>
> Mathieu
>
> ----- On Jun 10, 2015, at 11:27 AM, Jonathan Rajotte
> jonathan.rajotte-julien@efficios.com wrote:
>
> > Since the number of events present in the tests apps in prone to change
> it
> > make more sense to look for a minimum of events. This is less rigourous
> > but more flexible to change.
> >
> > Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> > ---
> > tests/regression/tools/mi/test_mi | 15 ++++++++++-----
> > 1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/tests/regression/tools/mi/test_mi
> > b/tests/regression/tools/mi/test_mi
> > index ccf9236..c44b598 100755
> > --- a/tests/regression/tools/mi/test_mi
> > +++ b/tests/regression/tools/mi/test_mi
> > @@ -328,7 +328,7 @@ function test_ust_lttng_event ()
> >       $XML_VALIDATE $OUTPUT_DEST
> >       ok $? "Mi test: Multiple enable ust event with inside fail xsd
> validation"
> >
> > -     #Check for 2 success =3D true et 1 false
> > +     #Check for 2 success =3D true and 1 success =3D false
> >       extract_xml $OUTPUT_DEST $XPATH_ENABLE_EVENT_SUCCESS result
> >       num_ocur=3D$(grep -o "true" <<< "$result" | wc -l)
> >       test "$num_ocur" -eq "2"
> > @@ -511,16 +511,21 @@ function test_list_ust_event ()
> >       $XML_VALIDATE $OUTPUT_DEST
> >       ok $? "Mi test: list ust event xsd validation"
> >
> > -     #Extract events 5 events should be present
> > +     #Extract events
> >       extract_xml $OUTPUT_DEST "$XPATH_LIST_UST_EVENT""/name/text()"
> result
> >       num=3D$(echo "$result" | wc -l)
> > -     test "$num" -eq "5"
> > +
> > +     #Since the number of events is prone to change we only look for >=
=3D
> from a
> > +     #base number. An alternative would be to look for each events but
> this
> > +     #is complicated for nothing.
> > +     test "$num" -ge "5"
> >       ok $? "Mi test: $num / 5 ust events discovered"
> >
> > -     #Extract field from tp:tptest event. Expect 12
> > +     #Extract field from tp:tptest event. Expect >=3D to 12 because
> number of
> > +     #field is prone to change.
> >       extract_xml $OUTPUT_DEST "$XPATH_LIST_UST_EVENT""[./name =3D
> >       'tp:tptest']/event_fields/event_field/name/text()" result
> >       num=3D$(echo "$result" | wc -l)
> > -     test "$num" -eq "12"
> > +     test "$num" -ge "12"
> >       ok $? "Mi test: $num / 12 ust event fields discovered"
> >
> >       #Wait for all background processes
> > --
> > 2.1.4
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a11c1dc94e673ee0518cc4d9b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged, thanks!<div><br></div><div>J=C3=A9r=C3=A9mie</div>=
</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Jun=
 18, 2015 at 10:18 AM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@e=
fficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">bump: J=
=C3=A9r=C3=A9mie, I know you are busy with Babeltrace, but can you quickly<=
br>
look into merging this fix ? It would repair the CI.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<div><div class=3D"h5"><br>
----- On Jun 10, 2015, at 11:27 AM, Jonathan Rajotte <a href=3D"mailto:jona=
than.rajotte-julien@efficios.com">jonathan.rajotte-julien@efficios.com</a> =
wrote:<br>
<br>
&gt; Since the number of events present in the tests apps in prone to chang=
e it<br>
&gt; make more sense to look for a minimum of events. This is less rigourou=
s<br>
&gt; but more flexible to change.<br>
&gt;<br>
&gt; Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.rajotte=
-julien@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt;<br>
&gt; ---<br>
&gt; tests/regression/tools/mi/test_mi | 15 ++++++++++-----<br>
&gt; 1 file changed, 10 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/tests/regression/tools/mi/test_mi<br>
&gt; b/tests/regression/tools/mi/test_mi<br>
&gt; index ccf9236..c44b598 100755<br>
&gt; --- a/tests/regression/tools/mi/test_mi<br>
&gt; +++ b/tests/regression/tools/mi/test_mi<br>
&gt; @@ -328,7 +328,7 @@ function test_ust_lttng_event ()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$XML_VALIDATE $OUTPUT_DEST<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ok $? &quot;Mi test: Multiple enable ust eve=
nt with inside fail xsd validation&quot;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0#Check for 2 success =3D true et 1 false<br>
&gt; +=C2=A0 =C2=A0 =C2=A0#Check for 2 success =3D true and 1 success =3D f=
alse<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0extract_xml $OUTPUT_DEST $XPATH_ENABLE_EVENT=
_SUCCESS result<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0num_ocur=3D$(grep -o &quot;true&quot; &lt;&l=
t;&lt; &quot;$result&quot; | wc -l)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0test &quot;$num_ocur&quot; -eq &quot;2&quot;=
<br>
&gt; @@ -511,16 +511,21 @@ function test_list_ust_event ()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$XML_VALIDATE $OUTPUT_DEST<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ok $? &quot;Mi test: list ust event xsd vali=
dation&quot;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0#Extract events 5 events should be present<br>
&gt; +=C2=A0 =C2=A0 =C2=A0#Extract events<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0extract_xml $OUTPUT_DEST &quot;$XPATH_LIST_U=
ST_EVENT&quot;&quot;/name/text()&quot; result<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0num=3D$(echo &quot;$result&quot; | wc -l)<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0test &quot;$num&quot; -eq &quot;5&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0#Since the number of events is prone to change we=
 only look for &gt;=3D from a<br>
&gt; +=C2=A0 =C2=A0 =C2=A0#base number. An alternative would be to look for=
 each events but this<br>
&gt; +=C2=A0 =C2=A0 =C2=A0#is complicated for nothing.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0test &quot;$num&quot; -ge &quot;5&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ok $? &quot;Mi test: $num / 5 ust events dis=
covered&quot;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0#Extract field from tp:tptest event. Expect 12<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0#Extract field from tp:tptest event. Expect &gt;=
=3D to 12 because number of<br>
&gt; +=C2=A0 =C2=A0 =C2=A0#field is prone to change.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0extract_xml $OUTPUT_DEST &quot;$XPATH_LIST_U=
ST_EVENT&quot;&quot;[./name =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;tp:tptest&#39;]/event_fields/event_fiel=
d/name/text()&quot; result<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0num=3D$(echo &quot;$result&quot; | wc -l)<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0test &quot;$num&quot; -eq &quot;12&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0test &quot;$num&quot; -ge &quot;12&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ok $? &quot;Mi test: $num / 12 ust event fie=
lds discovered&quot;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0#Wait for all background processes<br>
&gt; --<br>
&gt; 2.1.4<br>
&gt;<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
rel=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman=
/listinfo/lttng-dev</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--001a11c1dc94e673ee0518cc4d9b--


--===============0116407744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0116407744==--
