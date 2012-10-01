From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: UST app and lttng-tools compatibility
Date: Mon, 1 Oct 2012 11:31:59 -0400
Message-ID: <20121001153159.GB13944__27671.7090084732$1349105562$gmane$org@Krystal>
References: <50670C5A.4060800@gmail.com> <20120929182800.GA19994@Krystal>
	<5069111F.1080604@gmail.com> <20121001145619.GB13423@Krystal>
	<20121001152435.GA13628@Krystal> <5069B658.8010106@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TIhyS-0007GN-Kx
	for lttng-dev@lists.lttng.org; Mon, 01 Oct 2012 11:32:00 -0400
Content-Disposition: inline
In-Reply-To: <5069B658.8010106@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> 
> 
> Mathieu Desnoyers:
> > * Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> >> * Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> > [...]
> >>> Could the registration process block until the sessiond returns
> >>> some status?
> >> 
> >> The session is not "returning" anything to the application. The 
> >> application is registering to the sessiond, and all the sessiond
> >> can do is to keep the socket alive or close it.
> >> 
> >> Even if we added a "command" that the sessiond could use to tell
> >> the application it has a wrong version, that would not be 2.0
> >> material, and the application wouldn't know about it. Moreover,
> >> given we have changed the communication protocol, not sure we
> >> would like to have this extra command as entirely fixed for now,
> >> as it would be part of the communication protocol (which is not
> >> the case for the initial app registration, with is part of a
> >> lower level protocol).
> >> 
> >>> I understand that in commercial setup, the application should 
> >>> not be prevented to start and run normally if tracing is not
> >>> available or misconfigured.
> >> 
> >> By default, we only block the application for up to 3 seconds at 
> >> registration. I think that if we start the application with 
> >> LTTNG_UST_REGISTER_TIMEOUT=-1, the application will, in this
> >> case, block forever (see man lttng-ust).
> > 
> > Let me take this last part back. That was a pre-morning-coffee 
> > statement. ;) The application will receive a "registration done"
> > message when the version is found to be incompatible. Therefore, it
> > will never wait for the incompatible sessiond.
> > 
> > One thing we could do to make transition smoother between future 
> > versions would be to add a new command to let the sessiond send its
> > own version info to the application. In this command's handler,
> > the application could show a warning on stderr. This could not
> > apply to 2.0, but we could do it starting from 2.1.
> > 
> > Thoughts ?
> 
> Why sending version infos instead of a "incompatible" command ?

It could very well be an "incompatible" command, but it would need to
contain the version info, so the application can print the versions.

The main difference between sending version info (all the time) and the
"incompatible" command is that the version info would be sent all the
time. It could provide better debugging logs in the app when using
LTTNG_UST_DEBUG=1, but would require one extra message at app
registration. Not sure which is best.

Thoughts ?

Thanks,

Mathieu

> 
> David
> 
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> > 
> -----BEGIN PGP SIGNATURE-----
> 
> iQEcBAEBCgAGBQJQabZVAAoJEELoaioR9I02RYcIALJ7ySGiU6nKDD4F4ffAEIFr
> ZSQC/1mhr8x66TfTdB9eGaAxA6qmESEBpg6bjyWSmWCn1dI1i5lOeXhxszM1Z8Oz
> q6DKSSlRVRZFrCaZBf3Xy7QNbxTdUkwrcCjd8Y9Ffu1BswXIzzUhsYSHbJRQAHVF
> QAuNFy5AeHRlE55H94Gs/ydfiQb3jqVIalVnG5LmeDPyO58sdA+RAWkwaJypgL8e
> 5m6r3K0IK5ufSIjWWb6G8vmf3HFV3zzdEwGpkEyaVRZjUfDBekRnJ27Bb2XqJUxC
> /xe2S519VLnsCWE+j1pfN5BcchI0TKUOeTcaLzzaf/VdkHdlOmZlifSZ6ubRusU=
> =OVEY
> -----END PGP SIGNATURE-----

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
