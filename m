From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: [Announcement][Eclipse viewer][CTF] Better error
	messages
Date: Tue, 23 Apr 2013 11:05:16 -0400
Message-ID: <5176A32C.5050009__18357.8382050202$1366729605$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1UUenO-0002jm-Fr
	for lttng-dev@lists.lttng.org; Tue, 23 Apr 2013 11:06:14 -0400
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

Hi tracing luchadores and luchadorettes,
this is a small feature but I know some of you are making your own CTF
traces. I am just giving a heads up that the eclipse viewer as of
yesterday has improved error messages.

The messages before:
"The trace was invalid"

Now:
General "File not found: xxx"
General "xxx is not a directory, expecting a directory"
General "xxx is not a file, expecting a file"
TSDL "Mismatched token: expecting X, found Y on line ###"
TSDL "Only one trace block is allowed"
TSDL "Missing trace block"
TSDL "Trace byte order not set"
TSDL "Left side of CTF assignment must be a string" ...

Sorry, this list is rather exhaustive.

You can get it on the nightly builds for eclipse, or in a few months in
the Kepler release.
