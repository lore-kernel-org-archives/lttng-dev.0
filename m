From: Chidhu R <chid1989@gmail.com>
Subject: Multiple log level for SAME tracepoints
Date: Wed, 29 Apr 2015 11:37:28 -0700
Message-ID: <CAL1ZhONcn462-oWPKBB529YtwOaDaQDz04ETBHuiJtdKV1F_Wg__4285.10865099287$1430332759$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1877368195=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <chid1989@gmail.com>) id 1YnWsB-0002GP-B1
 for lttng-dev@lists.lttng.org; Wed, 29 Apr 2015 14:38:19 -0400
Received: by lbbuc2 with SMTP id uc2so27133455lbb.2
 for <lttng-dev@lists.lttng.org>; Wed, 29 Apr 2015 11:38:09 -0700 (PDT)
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

--===============1877368195==
Content-Type: multipart/alternative; boundary=001a11c354c2dd702d0514e14714

--001a11c354c2dd702d0514e14714
Content-Type: text/plain; charset=UTF-8

Hi,

I am having a situation where the same tracepoint should be used with
multiple loglevels.

Say for example, I have a tracepoint called HERE which prints the string "I
am here". Consider the following code.

int *a = (int *)malloc(10);
if(a) {
   tracepoint(HERE); // This can be INFO log level
}
else {
   // Malloc failed
   tracepoint(HERE); // This is critical and needs CRIT log level.
}

I am trying not to define multiple tracepoints just for this case. Can we
do this with LTTng?

-- Chid

--001a11c354c2dd702d0514e14714
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am having a situation where the s=
ame tracepoint should be used with multiple loglevels.=C2=A0</div><div><br>=
</div><div>Say for example, I have a tracepoint called HERE which prints th=
e string &quot;I am here&quot;. Consider the following code.</div><div><br>=
</div><div>int *a =3D (int *)malloc(10);</div><div>if(a) {</div><div>=C2=A0=
 =C2=A0tracepoint(HERE); // This can be INFO log level</div><div>}</div><di=
v>else {</div><div>=C2=A0 =C2=A0// Malloc failed</div><div>=C2=A0 =C2=A0tra=
cepoint(HERE); // This is critical and needs CRIT log level.</div><div>}</d=
iv><div><br></div><div>I am trying not to define multiple tracepoints just =
for this case. Can we do this with LTTng?</div><div><br></div><div>-- Chid<=
/div></div>

--001a11c354c2dd702d0514e14714--


--===============1877368195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1877368195==--
