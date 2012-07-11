From: David Goulet <dgoulet@efficios.com>
Subject: [NEW] lttng-tools network streaming
Date: Wed, 11 Jul 2012 14:39:56 -0400
Message-ID: <4FFDC87C.2080505__42858.7897135459$1342032030$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Sp1pQ-0004q0-4a
	for lttng-dev@lists.lttng.org; Wed, 11 Jul 2012 14:40:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 86A4A1871F1
	for <lttng-dev@lists.lttng.org>; Wed, 11 Jul 2012 14:40:01 -0400 (EDT)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kTaIuGjKlgPx for <lttng-dev@lists.lttng.org>;
	Wed, 11 Jul 2012 14:40:00 -0400 (EDT)
Received: from 127.0.0.1 (cable-13.246.173-198.electronicbox.net
	[173.246.13.198])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 74AF81871ED
	for <lttng-dev@lists.lttng.org>; Wed, 11 Jul 2012 14:40:00 -0400 (EDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi everyone,

I just pushed a huge amount of work into master of lttng-tools which
is the network streaming support. Please read the commit message
appended to this email for more information.

Since LTTng is an open source _community_, this feature is now in
"crowd sourcing QA mode" :). Feel free to test, report bugs,
contribute or comment on anything. Again, please do so!
(https://bugs.lttng.orgprojects/lttng-tools)

Here is a quick HOWTO in order to test the feature with kernel tracing
("remote" will receive the trace and "target" will stream the trace):

(remote) $ lttng-relayd -d  --> (daemonize the relayd)
(target) # lttng create mystream
         # lttng enable-consumer -k net://<remote_ip_or_hostname>
         # lttng enable-event -k sched_switch
         # lttng start
         # lttng stop
(remote) Check in $(HOME)/lttng-traces/<target_hostname>/...

Hopefully it will work for you :)

There is a known bug so please refer to the commit message below.

Big thanks to all the LTTng dev team especially Julien Desfossez
(relayd author), Mathieu Desnoyers and Yannick Brosseau for helping
with design, code and birth of this amazing feature :)!

Please note that man page for the relayd, streaming HOWTOs and
streaming protocol specification will come in the next days in doc/.
So for now, experiment with it and read the --help of each new command :).

Cheers! I'm out for a beer :D
David

commit 00e2e675d54dc726a7c8f8887c889cc8ef022003
Author: David Goulet <dgoulet@efficios.com>
Date:   Wed Jul 11 13:20:39 2012 -0400

    Network streaming support

    This is a huge commit integrating a lot of new feature for network
    streaming support with the lttng-relayd previously merged.

    Please note that this commit is the initial import of the network
    streaming feature meaning that this is NOT stable and SHOULD be
    considered experimental hence not suited for production deployment.

    API Changes:

    lttng_create_session_uri(), lttng_enable_consumer(),
    lttng_set_consumer_uri() and lttng_disable_consumer() calls are added.
    The lttng command line now supports these new calls by introducing two
    new commands and one modified. (Please look at the --help option for
    more details).

    $ lttng enable-consumer
    $ lttng disable-consumer

    The "lttng create" command can now take new arguments to specify the
    destination URI for network streaming. There is also a new flag which
    allows the user to disable the consumer for the session.

    At this point, the now old deprecated lttng_create_session() call is
    still supported but SHOULD be replaced by lttng_create_session_uri().
    More calls will be added to the API in order to facilitate the
creation
    of lttng URI.

    Network streaming:

    Both kernel and user space tracing are supported for network
streaming.
    For now, only IPv4 and IPv6 protocol over TCP is supported. Two
network
    socket are used where one is for control commands and the second
one is
    for data transmission. The port are respectively 5342 and 5343.

    BUGS: Streaming high throughput traces (e.g lttng enable-event -a -k)
    with low bandwitdh available to the relayd, the tracer does not behave
    well when the metadata are not emptied enough quickly so data are
    missing on the remote target and the tracing is simply not stoppable.
    This is a known bug and future iterations will try to fix it.

    WARNING: At this stage, there is _NO_ security features meaning no
    remote authentication on the relayd, no transport layer encryption or
    network secure handshake of some sort. So, uses only for in-vitro
    experiment or on _trusted_ networks.

    Signed-off-by: Julien Desfossez <julien.desfossez@efficios.com>
    Signed-off-by: David Goulet <dgoulet@efficios.com>
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJP/ch5AAoJEELoaioR9I02IYsH/RjaaUTWZDKL/sotQxfdKU/k
Xq1qjrCiluLbgLJ+CvQDPCIEXzzWbySfQG/REUVbvN9bjQ+DPBMBdpQ1V/bjiAFt
aOnpb8Om8YP1oMAXP+Mg7TYGTVMagAURx4IA1YP/Fkmv/tU+OhZEX00YDH3tu6Q6
sLTvEAzTBkrjh2HjeqlnKmevrZ4+OTr8LaNmDFznk3vUNyIkbGpFVYLfJWGI3CYF
3zAajqccZHosDDOVV1TMYkY+ZlVto20TJLjw5T+/efKaPcROpgnbN4guA5mdrDmr
heyt6kGnhS30XWaZ8MS57IuySCWCIhpGTWw9kGrd3zXhgYRa4cion3+oXN/KxSU=
=GEdj
-----END PGP SIGNATURE-----
