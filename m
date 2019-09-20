From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Free new_chunk on error
Date: Fri, 20 Sep 2019 17:42:10 -0400
Message-ID: <20190920214210.GC187569__12292.3362812557$1569015751$gmane$org@joraj-alpa>
References: <20190920144730.163268-1-jonathan.rajotte-julien@efficios.com>
 <20190920213426.GE20024@gmail.com>
 <20190920213714.GB187569@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46ZnHR4kyrzr0W
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 17:42:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20190920213714.GB187569@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

> =

> Okai, I saw a similar pattern somewhere in the file. Might want to check =
if the
> same can be applied there.

Nevermind it is in the release code.

> =

> > =

> > Thanks!
> > J=E9r=E9mie
> > =

> > >  	return NULL;
> > >  }
> > >  =

> > > -- =

> > > 2.17.1
> > > =

> =

> -- =

> Jonathan Rajotte-Julien
> EfficiOS
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Jonathan Rajotte-Julien
EfficiOS
