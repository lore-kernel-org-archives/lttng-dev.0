From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: babeltrace -i ?
Date: Tue, 7 May 2013 09:43:16 -0400
Message-ID: <20130507134316.GA5118__38228.6475542516$1367934230$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD01CF4B@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZiAn-0001sq-KP
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 09:43:17 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD01CF4B@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

Yep, a clearer error message could help. please file a bug on
bugs.lttng.org.

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
>    What is the babeltrace -i, --input-format option meant for?  At first =
I thought one could round-trip a CTF trace to text and back using babeltrac=
e, but if I try this:
> =

> $ babeltrace /path_to_the/ctf_trace_directory -w /path_to_the/text_trace_=
file
> $ babeltrace /path_to_the/text_trace_file -i text -o ctf -w /path_to_the/=
reconstituted_ctf_trace_directory
> =

>    The second command gives me:
> =

> [error] Cannot open any trace for reading.
> [error] opening trace "/path_to_the/text_trace_file" for reading.
> [error] none of the specified trace paths could be opened.
> =

>    If '-i ctf' is the only currently-implemented option, then we should g=
et a more appropriate error message when using another: something along the=
 lines of "babeltrace input format not supported ".
> =

> Daniel U. Thibault
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critica=
l Cyber Security (MCCS)
> Protection des syst=E8mes et contremesures (PSC) / Systems Protection & C=
ountermeasures (SPC)
> 2459 route de la Bravoure
> Qu=E9bec, QC=A0 G3J 1X5
> CANADA
> Vox=A0: (418) 844-4000 x4245
> Fax=A0: (418) 844-4538
> NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada=A0/ Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
