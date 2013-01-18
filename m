From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: yacc lttng-tools problem
Date: Fri, 18 Jan 2013 14:15:10 -0500
Message-ID: <20130118191510.GA17874__37600.824624724$1358536561$gmane$org@Krystal>
References: <3CA1A65C03C1A34C81BBC6272782E696987823@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<50F994BC.9090503@efficios.com>
	<3CA1A65C03C1A34C81BBC6272782E69698782F@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TwHPD-00056u-AP
	for lttng-dev@lists.lttng.org; Fri, 18 Jan 2013 14:15:11 -0500
Content-Disposition: inline
In-Reply-To: <3CA1A65C03C1A34C81BBC6272782E69698782F@valcartierex01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: lttng-dev@lists.lttng.org, "Couture, Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
> -----Message d'origine-----
> De=A0: David Goulet [mailto:dgoulet@efficios.com] =

> Envoy=E9=A0: 18 janvier 2013 13:30
> =

> Make sure also you have these packages:
> =

> - flex >=3D 2.5.35
> - bison >=3D 2.4
> =

> David
> -----Fin du message d'origine-----
> =

>    Flex was the missing package (far, far from obvious).  It works now!

Please read the "README" files found in each project root directory
before building. These document, amongst other important things, the
dependencies that need to be installed in order to build each project.

Thank you,

Mathieu

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
