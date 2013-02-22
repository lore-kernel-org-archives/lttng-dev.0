From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: babeltrace omits its closing verbose comment
Date: Fri, 22 Feb 2013 15:28:19 -0500
Message-ID: <20130222202819.GB25956__44322.5196366713$1361564948$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD01C9AC@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1U8zEC-00012S-FY
	for lttng-dev@lists.lttng.org; Fri, 22 Feb 2013 15:28:20 -0500
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD01C9AC@VAL-E-01.valcartier.drdc-rddc.gc.ca>
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

Good point, although the fix is not the one you proposed. See upstream
commit:

commit 9a3bb76ad636d5b5904e611ee8b4553d900a807c
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri Feb 22 15:26:47 2013 -0500

    Fix: ctf-text: don't close stdout
    =

    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
> The verbose output of babeltrace (-v, --verbose) is missing its closing c=
omment.  Looking at babeltrace.c, line 670:
> =

> fmt_write->close_trace(td_write);
> =

> bt_context_put(ctx);
> printf_verbose("finished converting. Output written to:\n%s\n",
> 		opt_output_path ? : "<stdout>");
> goto end;
> =

> I suspect that the printf_verbose should be moved to *before* the fmt_wri=
te->close_trace.  That way the last comment would be sent to stdout (or the=
 user-selected --output, once bug 459 (http://bugs.lttng.org/issues/459) is=
 fixed), right?
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
