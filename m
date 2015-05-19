From: Aravind HT <aravind.ht@gmail.com>
Subject: lttng soft hang issue
Date: Tue, 19 May 2015 16:36:06 +0530
Message-ID: <CACd+_b7fKbkmSKkqH85Mo-+HAsH2e9v_mW0-9fmQScquy1UJHA__827.498632907186$1432140942$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1135099770=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f50.google.com ([209.85.215.50])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <aravind.ht@gmail.com>) id 1YufLg-0008FU-HK
 for lttng-dev@lists.lttng.org; Tue, 19 May 2015 07:06:19 -0400
Received: by laat2 with SMTP id t2so17705037laa.1
 for <lttng-dev@lists.lttng.org>; Tue, 19 May 2015 04:06:06 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1135099770==
Content-Type: multipart/alternative; boundary=001a11c3538405e63005166d4cfd

--001a11c3538405e63005166d4cfd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,



I have recently started trying lttng 2.6 for a few applications on my
Ubuntu 12.04 and I noticed that the health check on sessiond and consumerd
failed soon after starting the session.


On investigating, I found that thread_manage_consumer() had exited causing
an overall health check failure.


Here are the sequence of steps that I found contributed to
*thread_manage_consumer()* exiting.


1.       In *thread_manage_apps() : 1558 , ust_app_unregister(pollfd)* is
being called. This happens when there is an error detected by *revents =3D
LTTNG_POLL_GETEV(&events, i) *

My initial guess here is that as one of my apps has crashed, producing
a *LPOLLERR
| LPOLLHUP | LPOLLRDHUP *to be generated for *epoll()* causing
*ust_app_unregister()* to be called for that app.



2.       In *ust_app_unregister():3154 , close_metadata(registry,
ua_sess->consumer)  *in which* registry->metadata_closed =3D 1 *is set*. *



(2.a) Note:* close_metadata() *also calls* consumer_close_metadata() *which
sends* LTTNG_CONSUMER_CLOSE_METADATA *and* metadata_key *to the consumerd
to stop it from further dealing with the concerned app. Somehow this
doesn=E2=80=99t seem to help*.*



3.       Next, I see that the *thread_manage_consumer():1353* for some
reason has ignored the above 2.a and gets to do request/reply for that app
by calling *ust_consumer_metadata_request():491 ->
ust_app_push_metadat(ust_reg, socket,1) *which at line 460 checks for
*registry->metadata_closed* and returns an *=E2=80=93EPIPE*



4.       This *=E2=80=93EPIPE* error cascades all the way back up to
*thread_manage_consumer():1353* at which point *thread_manage_consumer()*
decides to exit causing health_check() to fail.





So it looks like under some scenario, an application crash could cause the
lttng some problems.



I think a possible fix for this scenario, is to instead of 4, send an
*ERROR* message back to *consumerd()* . This could be done from
*ust_consumer_metadata_request()* call. Can someone please let me know if
this is correct and shed more light on the issue ?





Please forgive if there are any guideline omissions for posting here from
my part. This is my first post.


Regards,

Aravind.

--001a11c3538405e63005166d4cfd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"MsoNormal">Hi,</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">I have recently started trying lttng 2.6 for a few
applications on my Ubuntu 12.04 and I noticed that the health check on sess=
iond
and consumerd failed soon after starting the session.</p><p class=3D"MsoNor=
mal"><br></p>

<p class=3D"MsoNormal">On investigating, I found that thread_manage_consume=
r() had
exited causing an overall health check failure.</p><p class=3D"MsoNormal"><=
br></p><p class=3D"MsoNormal">Here are the sequence of steps that I found c=
ontributed to <b>thread_manage_consumer()</b> exiting.</p><p class=3D"MsoNo=
rmal"></p>

<p class=3D"MsoNormal"><br></p>

<p class=3D"" style>1.<span style=3D"font-stretch:normal;font-size:7pt;font=
-family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span>In <b>thread_manage_apps()
: 1558 , ust_app_unregister(pollfd)</b> is being called. This happens when
there is an error detected by <b>revents =3D
LTTNG_POLL_GETEV(&amp;events, i) </b></p>

<p class=3D"">My initial guess here is that as one of my apps has
crashed, producing a <b>LPOLLERR | LPOLLHUP
| LPOLLRDHUP </b>to be generated for <b>epoll()</b>
causing <b>ust_app_unregister()</b> to be
called for that app.</p>

<p class=3D"">=C2=A0</p>

<p class=3D"" style>2.<span style=3D"font-stretch:normal;font-size:7pt;font=
-family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span>In <b>ust_app_unregister():3154
, close_metadata(registry, ua_sess-&gt;consumer)=C2=A0 </b>in which<b> regi=
stry-&gt;metadata_closed =3D 1 </b>is set<b>. </b></p>

<p class=3D"" style=3D"text-indent:0.5in">=C2=A0</p>

<p class=3D"" style=3D"text-indent:0.5in">(2.a) Note:<b> close_metadata() <=
/b>also calls<b> consumer_close_metadata() </b>which sends<b> LTTNG_CONSUME=
R_CLOSE_METADATA </b>and<b> metadata_key </b>to the consumerd to stop
it from further dealing with the concerned app. Somehow this doesn=E2=80=99=
t seem to
help<b>.</b></p>

<p class=3D""><b>=C2=A0</b></p>

<p class=3D"" style>3.<span style=3D"font-stretch:normal;font-size:7pt;font=
-family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span>Next, I see that the <b>thread_manage_consumer():1353</b> for some r=
eason has ignored the above
2.a and gets to do request/reply for that app by calling <b>ust_consumer_me=
tadata_request():491 -&gt; ust_app_push_metadat(ust_reg,
socket,1) </b>which at line 460 checks for <b>registry-&gt;metadata_closed<=
/b>
and returns an <b>=E2=80=93EPIPE</b></p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"" style>4.<span style=3D"font-stretch:normal;font-size:7pt;font=
-family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span>This <b>=E2=80=93EPIPE</b>
error cascades all the way back up to <b>thread_manage_consumer():1353</b>
at which point <b>thread_manage_consumer()</b>
decides to exit causing health_check() to fail.</p>

<p class=3D"">=C2=A0</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">So it looks like under some scenario, an application=
 crash
could cause the lttng some problems.</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">I think a possible fix for this scenario, is to inst=
ead of 4, send an <b>ERROR</b>
message back to <b>consumerd()</b> . This could be done from <b>ust_consume=
r_metadata_request()</b> call. Can
someone please let me know if this is correct and shed more light on the is=
sue
?</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">=C2=A0</p><p class=3D"MsoNormal">Please forgive if t=
here are any guideline omissions for posting here from my part. This is my =
first post.</p><p class=3D"MsoNormal"><br></p>

<p class=3D"MsoNormal">Regards,</p>

<p class=3D"MsoNormal">Aravind.</p></div>

--001a11c3538405e63005166d4cfd--


--===============1135099770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1135099770==--
