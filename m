From: Matthew Khouzam <matthew.khouzam-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Tmf Ctf Parser Scalability issues (2/3)
Date: Tue, 26 Nov 2013 11:44:48 -0500
Message-ID: <5294D000.60505@ericsson.com>
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

Issue 2: Packet size
CTF can have an packet with an unlimited size in within a stream. We use
a memory map to access the data. We are limited to 2GB as the size of an
individual packet, as far as I know. If a packet is larger this will
make the trace unreadable. I can imagine hardware tracers that have ~3gb
buffers and dump them to a file in a single packet would be affected by
this.

Proposed solution:
I envision fixing them by having a sliding window of the maximum memory
map size. I see a problem if a single event is say 3GB in size, but I
can't see a short term solution for that, would you have any suggestions
on this front?
