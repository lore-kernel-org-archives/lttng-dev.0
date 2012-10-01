From: David Goulet <dgoulet@efficios.com>
Subject: Re: UST app and lttng-tools compatibility
Date: Mon, 01 Oct 2012 11:06:44 -0400
Message-ID: <5069B184.4060903__7562.37807586348$1349104051$gmane$org@efficios.com>
References: <50670C5A.4060800@gmail.com> <20120929182800.GA19994@Krystal>
	<5069111F.1080604@gmail.com> <20121001145619.GB13423@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TIha5-0006vv-EP
	for lttng-dev@lists.lttng.org; Mon, 01 Oct 2012 11:06:49 -0400
In-Reply-To: <20121001145619.GB13423@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Mathieu Desnoyers:
> * Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
>> Le 2012-09-29 14:28, Mathieu Desnoyers a =E9crit :
>>> * Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
>>>> Hi,
>>>> =

>>>> I wanted to share my lttng-ust 2.1 update experience, maybe
>>>> it will save time for others.
>>>> =

>>>> I updated lttng-ust recently. After this change, the app
>>>> would not produce a trace anymore. No error message is
>>>> displayed by the traced app to indicate that something is
>>>> wrong. Even when setting LTTNG_DEBUG_UST to the app's
>>>> environment variable, there is no error message. The debug =

>>>> output suggests that probes are registered and everything is
>>>> fine, while it's not.
>>>> =

>>>> By running lttng-sessiond with -vvv --verbose-consumer, I
>>>> finally got this message:
>>>> =

>>>> DEBUG2: UST app PID 8112 is not compatible with major version
>>>> 3 (supporting <=3D 2) [in ust_app_validate_version() at
>>>> ust-app.c:2633]
>>>> =

>>>> Updating lttng-tools to 2.1 solved the issue. Seems that it's
>>>> mandatory to update lttng-tools to support latest lttng-ust.
>>>> It may be obvious for developers, but it should be clear for
>>>> users that they must upgrade both.
>>>> =

>>>> IMHO, It would be nice if the app side log could tell if the =

>>>> session/consumer refused the registration.
>>> =

>>> I agree we should do better.
>>> =

>>> Regarding lttng-tools, I think changing this DBG2 message to a
>>> WARN message would help, so sessiond would show the warning,
>>> except in the case where it is started with "-d".
>> =

>> Excellent idea.
> =

> David, can you make this change ?
> =


Yes!

David

>> =

>>> On the application side, this is a bit tricky. It has no way to
>>> find out that it has been rejected by the sessiond. The
>>> application registers at startup, and then the sessiond keeps
>>> the connexion active, but flags it as incompatible internally.
>>> The reason we do that is because we don't want the application
>>> to retry endlessly.
>> =

>> Could the registration process block until the sessiond returns
>> some status?
> =

> The session is not "returning" anything to the application. The =

> application is registering to the sessiond, and all the sessiond
> can do is to keep the socket alive or close it.
> =

> Even if we added a "command" that the sessiond could use to tell
> the application it has a wrong version, that would not be 2.0
> material, and the application wouldn't know about it. Moreover,
> given we have changed the communication protocol, not sure we would
> like to have this extra command as entirely fixed for now, as it
> would be part of the communication protocol (which is not the case
> for the initial app registration, with is part of a lower level
> protocol).
> =

>> I understand that in commercial setup, the application should not
>> be prevented to start and run normally if tracing is not
>> available or misconfigured.
> =

> By default, we only block the application for up to 3 seconds at =

> registration. I think that if we start the application with =

> LTTNG_UST_REGISTER_TIMEOUT=3D-1, the application will, in this case,
> block forever (see man lttng-ust).
> =

> Thanks!
> =

> Mathieu
> =

>> But for developers, some env var like "LTTNG_ABORT_ON_ERROR"
>> could help to diagnose this king of problem.
>> =

>>> Moreover, I cannot change the code for the existing 2.0 UST
>>> libs, so adding a new message is not possible.
>> =

>> Of course! ;)
>> =

>>> One thing we have in mind for 2.2 or 2.3 is to add syslog
>>> support within the sessiond. This would provide a nice
>>> centralized place to look at those logs.
>> =

>> I think it would be great. It's a bit less hidden, but certainly
>> address concerns for production, and still can be used by
>> developers. An error message is better than no one! ;)
>> =

>> Cheers,
>> =

>> Francis
>> =

>> =

>> =

> =

> =

> =

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQabGBAAoJEELoaioR9I024c0IAJ8i7hIUthhQdbeESSV6T65L
VgxPYtjUr2aKbOaeInS1FXiW39Gpg5w1Xut9gTaAmlxP+Dsgs1TXLVx0YJFCsqi0
QYrkPLbpdafmCjbXKpWa6G5hNCFa684MorL6hCqhSOQEBXD0N/aKGQmUVz+pxGXp
xR/l/hwHadm4v6VH75N5dr5JvGNHQbcZDYz0gzokemyo1edw0NGa3jQGe0WYcVcp
/K6hybbgRvkZObMB2hhTESkLwAFk/OO4WEP6zTZCSPLCTAdiGLaWNQQ9PdxxkcT+
crT83mDSW8K1yQkZDXOk5U9XSmdBLjBuQW6094EaCF9Nb5K6d+y2U01dii4eIU4=3D
=3D6aHd
-----END PGP SIGNATURE-----
