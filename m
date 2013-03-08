From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [LTTNG-TOOLS PATCH] On-disk multiple tracefiles
	circular buffer
Date: Fri, 8 Mar 2013 14:34:31 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD026557__8235.96353079683$1362753370$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UDyOA-0006K5-0n
	for lttng-dev@lists.lttng.org; Fri, 08 Mar 2013 09:35:14 -0500
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

> @@ -78,6 +80,8 @@ static struct poptOption long_options[] =3D {
>  	{"read-timer",     0,   POPT_ARG_INT, 0, OPT_READ_TIMER, 0, 0},
>  	{"list-options",   0, POPT_ARG_NONE, NULL, OPT_LIST_OPTIONS, NULL, NULL=
},
>  	{"output",         0,   POPT_ARG_STRING, &opt_output, 0, 0, 0},
> +	{"tracefile_size", 'C',   POPT_ARG_INT, 0, OPT_TRACEFILE_SIZE, 0, 0},
> +	{"tracefile_count", 'W',   POPT_ARG_INT, 0, OPT_TRACEFILE_COUNT, 0, 0},
>  	{0, 0, 0, 0, 0, 0, 0}
>  };
>
> @@ -117,6 +121,8 @@ static void usage(FILE *ofp)
>  		DEFAULT_CHANNEL_READ_TIMER);
>  	fprintf(ofp, "      --output TYPE        Channel output type (Values: %=
s, %s)\n",
>  			output_mmap, output_splice);
> +	fprintf(ofp, "  -C, --tracefile-size NUM     Maximum size of tracefiles=
 (in bytes)\n");
> +	fprintf(ofp, "  -W, --tracefile-count NUM    Number of tracefiles to ke=
ep\n");
>  	fprintf(ofp, "\n");
>  }

   You've got the command options parsed as "tracefile_size" but documented=
 as "tracefile-size" (likewise for _count/-count).  The latter is preferabl=
e for consistency with the rest of the user interface.
 =

> @@ -175,6 +187,15 @@ static int enable_channel(char *session_name)
>
>	set_default_attr(&dom);
>
> +	if ((chan.attr.tracefile_size > 0) &&
> +			(chan.attr.tracefile_size < chan.attr.subbuf_size)) {
> +		ERR("Tracefile_size must be superior or equal to subbuf_size "
> +				"(%" PRIu64 " < %" PRIu64 ")",
> +				chan.attr.tracefile_size, chan.attr.subbuf_size);
> +		ret =3D CMD_ERROR;
> +		goto error;
> +	}

   That should be ERR("The tracefile-size must be superior or equal to the =
subbuf-size ".

   I hope the man pages will make clear how these two new command options w=
ork, as the initial presentation of tracefile-size as the "Maximum size of =
tracefiles (in bytes)" and tracefile-count as the "Number of tracefiles to =
keep" can be understood quite wrongly.  It can be misconstrued to mean each=
 trace file is limited in size (so only the first SIZE bytes are captured, =
the rest is thrown away), or that the limitation applies to the *set* of tr=
ace files (maximum total size of trace files, the sum being over all CPU ID=
s for that channel).  The chunking mechanism should also explain its circul=
arity, as a user could initially expect the trace file chunk numbering to b=
e open-ended, the excess files (assuming tracefile-count is set) being dele=
ted from the low-number end (e.g. a tracefile-count of two could be expecte=
d to yield, once the trace is concluded, the files "channel0_0_23" and "cha=
nnel0_0_24").

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
[Valcartier]\\vsi-wdut-o980, [Valcartier]\\edge
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada / Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
