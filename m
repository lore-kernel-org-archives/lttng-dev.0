From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: babeltrace omits its closing verbose comment
Date: Thu, 28 Feb 2013 21:08:17 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD021BDC__46912.0564325296$1362085780$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UBAih-00024f-DU
	for lttng-dev@lists.lttng.org; Thu, 28 Feb 2013 16:08:51 -0500
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Message: 1
Date: Fri, 22 Feb 2013 20:13:15 +0000
From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: [lttng-dev] babeltrace omits its closing verbose comment

> The verbose output of babeltrace (-v, --verbose) is missing its closing c=
omment.  Looking at babeltrace.c, line 670:
>
> fmt_write->close_trace(td_write);
>
> bt_context_put(ctx);
> printf_verbose("finished converting. Output written to:\n%s\n",
>		opt_output_path ? : "<stdout>");
> goto end;
>
> I suspect that the printf_verbose should be moved to *before* the fmt_wri=
te->close_trace.  That way the last comment would be sent to stdout
> (or the user-selected --output, once bug 459 (http://bugs.lttng.org/issue=
s/459) is fixed), right?

   Revisiting this, I see I was wrong in wanting the closing comment pushed=
 to stdout: it correctly belongs on stderr, like the '[verbose]' prologue t=
o the babeltrace conversion.  My mistake was caused by using 'babeltrace so=
metrace -v &> outputtrace' in order to circumvent the (now fixed) -w bug (I=
 should have used just '>').  This made me miss the distinction between wha=
t verbose pushes to stderr vs. what it pushes to stdout (or -w).  Quite cor=
rectly, --verbose changes only one thing in the output: it adds the stream.=
event.header to the event records.

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada / Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
