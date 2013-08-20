From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [RFC patch 3/3] [Babeltrace python bindings] Added
 missing typedef of ssize_t to babeltrace.i.in
Date: Tue, 20 Aug 2013 12:17:47 -0400
Message-ID: <CA+jJMxt+1q7AYtK65siaZfXc=jmmTBEiewGauP0RfmVHbYjwpw__920.108185573731$1377015549$gmane$org@mail.gmail.com>
References: <OFF39EE861.F113E1F5-ONC2257BCD.002B4E00-C2257BCD.002BCD61@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VBocz-0002d2-U7
	for lttng-dev@lists.lttng.org; Tue, 20 Aug 2013 12:17:59 -0400
Received: by mail-wi0-f179.google.com with SMTP id hr7so626270wib.6
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 09:17:47 -0700 (PDT)
In-Reply-To: <OFF39EE861.F113E1F5-ONC2257BCD.002B4E00-C2257BCD.002BCD61@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Tue, Aug 20, 2013 at 3:58 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> The file babeltrace.i.in contains a declaration of bt_get_int_len()
> returning ssize_t, which SWIG does not recognize as an integer (perhaps o=
nly
> in some cases).
> Adding a typedef causes generation of correct code.
>
> J=E9r=E9mie, perhaps your suggestion to solve this in config time is bett=
er, so
> I would leave this to your discretion.
>

Thanks for clarifying the problem in your previous e-mail. The
generated code, albeit ugly, works fine (unless I'm missing
something). I am tempted to leave it as is until we implement the
proper fix.

Thanks,
J=E9r=E9mie

>
>
> Thanks,
>
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
