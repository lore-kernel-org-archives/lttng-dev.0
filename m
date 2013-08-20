From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [RFC patch 2/3] [Babeltrace python bindings] Fixed
 use of braces in format strings,
 to allow use with older Python versions (e.g. 2.6)
Date: Tue, 20 Aug 2013 12:32:57 -0400
Message-ID: <CA+jJMxs6XNjJZBFv68pzM34VUgiCKvgbB1mBjLpwWHZN2cG=ZA__26322.7359428585$1377016486$gmane$org@mail.gmail.com>
References: <OF9136DF48.7319E766-ONC2257BCD.002AA76A-C2257BCD.002AFEDA@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VBorf-0003Yj-U3
	for lttng-dev@lists.lttng.org; Tue, 20 Aug 2013 12:33:09 -0400
Received: by mail-wi0-f170.google.com with SMTP id hi8so5093875wib.3
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 09:32:58 -0700 (PDT)
In-Reply-To: <OF9136DF48.7319E766-ONC2257BCD.002AA76A-C2257BCD.002AFEDA@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Acked-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>

On Tue, Aug 20, 2013 at 3:50 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> Using braces in format strings without specifying a number (e.g. "The num=
ber
> {} is incorrect".format(some_variable)) is available since Python 2.7, and
> older Python 2.6 required a number, zero-based (e.g. "The number {0} is
> incorrect").
>
> This patch adds these numbers for the sake of older systems.
>
>
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
