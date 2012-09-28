From: David Goulet <dgoulet@efficios.com>
Subject: Re: [GIT PULL lttng-tools] Please pull from compudj-pull
Date: Fri, 28 Sep 2012 16:53:25 -0400
Message-ID: <50660E45.8090204__9836.3792909824$1348865785$gmane$org@efficios.com>
References: <20120928204557.GA22248@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1THhYw-0008Il-78
	for lttng-dev@lists.lttng.org; Fri, 28 Sep 2012 16:53:30 -0400
In-Reply-To: <20120928204557.GA22248@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Pulled!

Mathieu Desnoyers:
> Hi David,
> 
> Please pull from compudj-pull at commit:
> 
> commit 3870fc0dddd945410af05ac9e65f041acf84731a Author: Mathieu
> Desnoyers <mathieu.desnoyers@efficios.com> Date:   Fri Sep 28
> 16:41:25 2012 -0400
> 
> Fix: consumer_allocate_stream error handling
> 
> Fix a memory leak and "be nice" when handling stream alloc errors.
> Upon CPU hotplug, it is possible that we receive a stream only
> after all other streams are finalized, which means it could happen
> that we discard that channel, in the unlikely event that we have
> cpu hotplug concurrently with destroy.
> 
> Moreover, this fix the return path of channel lookup failure: we
> were returning an zeroed stream rather than returning an error,
> which was certainly not the intended behavior.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Thanks!
> 
> Mathieu
> 
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQZg5CAAoJEELoaioR9I02IZ0H/jfw63XUaIicL5Z5SPZQ7bmY
mvp0AtzqHejvhGp9x1uU62OB8bag2jU9hi0mBiGe8I5xZv8Bu5iSXbWu8KZAKCaG
JJXpg7M2IVkzVzPuYxr64wcBL7D90ESdbdpHJ6t7oHL/eZ8lgeGEOlu6TjNW+Eum
D8rn7uBlEWHzxLWJWKvI+CgbJRSWPbZNbq8ECo2hvutHcKvW18ImJxpwFFi1KUUA
HmFDs+5mtNx5yAHFBdGBl8ADFtMdTS6UY1WDgF+3A01glgSchHF7LqW5fWl+6Ni5
yOdvFUSH/hDkHsZESpARKTRrGI2Iovq2ipOXQhPxyuY03mL6iMKLqHmzqCu//Yk=
=Fzmx
-----END PGP SIGNATURE-----
