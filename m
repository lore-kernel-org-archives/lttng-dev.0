From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC] New LTTng domain
	attributes	(buffer/include/exclude)
Date: Tue, 7 May 2013 11:26:51 -0400
Message-ID: <20130507152651.GA6601__41433.6819471375$1367940445$gmane$org@Krystal>
References: <20130306180313.GA9899@Krystal> <51385B87.5010500@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZjn3-0002tf-5o
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 11:26:53 -0400
Content-Disposition: inline
In-Reply-To: <51385B87.5010500@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Woegerer, Paul (Paul_Woegerer@mentor.com) wrote:
> On 03/06/2013 07:03 PM, Mathieu Desnoyers wrote:
> > Other future attributes we plan on adding are inclusion/exclusion lists,
> > followed by a comma-separated list:
> > =

> >   --include-pid 22,33,44
> >   --include-uid 0,5
> >   --exclude-pid 12,55
> >   --exclude-uid 22
> =

> How about child processes of the given pids ? Would it be the default to
> also collect their events into the buffer ?

No, I'm thinking of a --follow-child (-f), similarly to strace.

Thoughts ?

Thanks,

Mathieu

> =

> -- =

> Paul Woegerer | SW Development Engineer
> http://go.mentor.com/sourceryanalyzer
> =

> Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
> Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS
> =

> Android is a trademark of Google Inc. Use of this trademark is subject
> to Google Permissions.
> Linux is the registered trademark of Linus Torvalds in the U.S. and
> other countries.
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
