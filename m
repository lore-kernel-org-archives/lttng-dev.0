From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: Running lttng-tools testsuite against an installed
 codebase
Date: Fri, 13 Sep 2013 16:02:15 -0400
Message-ID: <52336F47.1090703__37309.8207907335$1379102600$gmane$org@mentor.com>
References: <CAGDH53mDNwdbvhNQFJAAVcECM6ttsv3PjUDCqu3MZitfBrSHbA@mail.gmail.com>
	<5233111F.7080805@mentor.com>
	<CAGDH53=XZcss0GgRRRDxW7sqanH_c3Oy2gqMqXUFMG=x48LdwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1VKZZQ-0004ys-O5
	for lttng-dev@lists.lttng.org; Fri, 13 Sep 2013 16:02:30 -0400
In-Reply-To: <CAGDH53=XZcss0GgRRRDxW7sqanH_c3Oy2gqMqXUFMG=x48LdwA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 09/13/2013 03:56 PM, Christian Babeux wrote:
>> Of course, that would break the `make check` target as for in-development testing
>> the binaries would no longer be found. Is there any reason a simple
>> adjustment of the PATH variable would not be enough ?
> 
> One of the issue I see with overriding the PATH _only_ in the make
> check target is that we will no longer be able to run each tests
> separately from the command line.

For avoidance of doubt, I'm not suggesting to modify PATH from within
the Makefile. I'd do that before invoking 'make'.

And thus, running tests individually should work just as fine, and pick
up executables according to your settings.

> Poking a bit around, I saw that the git project also use a TAP
> testsuite. They get around the issue of binary path resolving via a
> test-lib (similar to our tests/utils/utils.sh) which is sourced in
> each scripts and adjust the paths accordingly.

Setting up the environment with a convenience script sounds fine, but I
still don't understand why this would be called by the test harness,
rather than manually before the test harness is invoked. Keeping the two
separate sounds much simpler and less error-prone to me.

	Stefan


-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/
