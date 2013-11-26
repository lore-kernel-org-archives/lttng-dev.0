From: Matthew Khouzam <matthew.khouzam-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Tmf Ctf Parser Scalability issues (3/3)
Date: Tue, 26 Nov 2013 11:44:51 -0500
Message-ID: <5294D003.5040104@ericsson.com>
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

Issue 3: Event size
As hinted in the previous email, it can definitely be a possibility that
traces can have events that are too large to fit into memory. These
events could also make reading a packet difficult, since the packet
could have a said event in the middle, and therefore, we could end up
with a packet that cannot be read properly with the sliding window
memory map, unless corrective actions are taken.

Proposed solution:
Would anyone do this? I see it as a longer term problem and as a known
limitation, unless someone says "Hey, I want 8gb events!".
