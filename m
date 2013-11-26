From: Matthew Khouzam <matthew.khouzam-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Tmf Ctf Parser Scalability issues (1/3)
Date: Tue, 26 Nov 2013 11:44:46 -0500
Message-ID: <5294CFFE.2070001@ericsson.com>
Reply-To: Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://dev.eclipse.org/mailman/options/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://dev.eclipse.org/mailman/private/linuxtools-dev>
List-Post: <mailto:linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <https://dev.eclipse.org/mailman/listinfo/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=subscribe>
Errors-To: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
Sender: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
To: "lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org" <lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org>, Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Id: lttng-dev@lists.lttng.org

Hello all,
I was looking at the CTF parser in the TMF project of Linux Tools. I
have come up with three points where scalability will be an issue. I am
sending 3 emails, each one describing one of the issues so we can
aggregate them more cohesively. First a primer, CTF is a file format
that has traces written in packets, the packets are parts of files in
streams, the streams are files in a directory.

Issue 1: Number of open files
CTF can have an unlimited amount of stream files. The parser opens all
of them simultaneously. This means if you have say over 1024 or whatever
your file limit is, files opened simultaneously, you will hit a wall. An
example of this would be the new Xeon Phi boards that have something
like 255 cores, if you have more than 4 channels per core, you're going
to hit this issue.

Proposed solution:
I envision fixing them by setting up a pool of files and when the limit
is hit, swapping files in and out, incurring a performance hit but still
allowing the program to run. Any objections?
