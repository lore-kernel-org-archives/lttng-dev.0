From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Difference in metadata between per-PID
	and	per-UIDtraces
Date: Tue, 10 Sep 2013 17:05:41 -0400
Message-ID: <20130910210541.GA15448__71.7754279778049$1378847200$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD2678ED56@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<20130910201751.GA14222@Krystal>
	<48CF5AC71E61DB46B70D0F388054EFFD2678ED71@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<20130910203112.GA14529@Krystal> <522F879E.9070209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VJV83-00037d-3R
	for lttng-dev@lists.lttng.org; Tue, 10 Sep 2013 17:05:48 -0400
Content-Disposition: inline
In-Reply-To: <522F879E.9070209@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> On 2013-09-10 16:31, Mathieu Desnoyers wrote:
> > * Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
> >> -----Message d'origine-----
> >> De : Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com] =

> >> Envoy=E9 : 10 septembre 2013 16:18
> >>
> >>>  > And why is "tracer_patchlevel" dropped alongside the process-relat=
ed attributes?
> >>>
> >>> Because different processes could use different tracer versions.
> >>    How is such a situation handled in the per-UID case?
> > There are version checks for each application. We don't keep this
> > information in the trace metadata, because it is shared across apps.
> >
> Would it be interesting to put the PID of each traced application in the
> metadata file?

Not really.

Mathieu

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
