From: Alok Priyadarshi <alokpr@gmail.com>
Subject: Re: lost trace events
Date: Wed, 7 Nov 2018 11:53:25 -0800
Message-ID: <CADwgpi9Hpm9hYuRi9y9qOVyUvoGWcVkX0ZEm6AvQaPyeN_QWkQ__14140.6419490979$1541620301$gmane$org@mail.gmail.com>
References: <CADwgpi8TmCUgz4uF8CpPs-1-SooENXvYgA2ZqjXbcMgsSwzRdg@mail.gmail.com>
 <20181107153120.GA15594@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6341989211285957451=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 by lists.lttng.org (Postfix) with ESMTPS id 42qxtV4Wlnzqj2
 for <lttng-dev@lists.lttng.org>; Wed,  7 Nov 2018 14:53:38 -0500 (EST)
Received: by mail-yb1-xb34.google.com with SMTP id j9-v6so7338907ybj.6
 for <lttng-dev@lists.lttng.org>; Wed, 07 Nov 2018 11:53:38 -0800 (PST)
In-Reply-To: <20181107153120.GA15594@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6341989211285957451==
Content-Type: multipart/alternative; boundary="000000000000534d90057a18793b"

--000000000000534d90057a18793b
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

Thanks for your response.

We are tracing function scopes. Each scope emits two events - begin and
end. We noticed that some begin events did not have corresponding end
events in the trace.

I have the trace with this problem available. Would that provide any clue?
If not, I will try to extract a small reproducer.

-Alok

--000000000000534d90057a18793b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jonathan,<div><br></div><div>Thanks for your response.<=
/div><div><br></div><div>We are tracing function scopes. Each scope emits t=
wo events - begin and end. We noticed that some begin events did not have c=
orresponding end events in the trace.</div><div><br></div><div>I have the t=
race with this problem available. Would that provide any clue? If not, I wi=
ll try to extract a small reproducer.</div><div><br></div><div>-Alok</div><=
div><br></div></div>

--000000000000534d90057a18793b--

--===============6341989211285957451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6341989211285957451==--
