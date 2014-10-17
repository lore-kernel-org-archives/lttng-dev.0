From: "Boisvert, Sebastien" <boisvert@anl.gov>
Subject: Best way to analyze CTF files
Date: Fri, 17 Oct 2014 22:23:29 +0000
Message-ID: <E949C1E351B4914B87A26A5F96E06A9286AC1D__6654.18521170995$1413584651$gmane$org@PAYTON.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailrelay.anl.gov ([130.202.101.22])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <boisvert@anl.gov>) id 1XfFvs-0001K7-Eg
 for lttng-dev@lists.lttng.org; Fri, 17 Oct 2014 18:23:38 -0400
Received: from mailgateway.anl.gov (mailgateway.anl.gov [130.202.101.28])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by mailrelay.anl.gov (Postfix) with ESMTP id D27287CC40C
 for <lttng-dev@lists.lttng.org>; Fri, 17 Oct 2014 17:23:30 -0500 (CDT)
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Bonjour,

First, thank you for LTTng-UST. This is very useful and convenient.

I just got started today using LTTng (LTTng-UST) for tracing a HPC application 
that I am working on (I am a postdoc). I am impressed by how easy LTTng is to use it.

In my system, an actor message is represented by a pair
<message_actor_source, message_number>.

I want to list all messages that have a high delivery time (message:actor_receive - message:actor_send).

I am doing this to get the messages of one actor (actor 1000019):

[boisvert@bigmem biosal]$ babeltrace ~/lttng-traces/auto-20141017-181240|grep "message_source_actor = 1000019"  > actor_1000019

Then, I can look at one message with (message <1000019, 14>):

[boisvert@bigmem biosal]$ grep "message_number = 14," actor_1000019
[18:12:43.647017211] (+0.000005110) bigmem.knoxville.kbase.us message:actor_send: { cpu_id = 30 }, { message_number = 14, message_action = 31592, message_count = 8, message_source_actor = 1000019, message_destination_actor = 1000059, message_source_node = -1, message_destination_node = -1 }
[18:12:43.647025249] (+0.000002860) bigmem.knoxville.kbase.us message:actor_receive: { cpu_id = 49 }, { message_number = 14, message_action = 31592, message_count = 8, message_source_actor = 1000019, message_destination_actor = 1000059, message_source_node = 3, message_destination_node = 3 }

If I substract the times:

irb(main):003:0> (43.647025249-43.647017211)*10**9
=> 8038.00000426236

This message (<1000019, 14>) required 8038 ns for the delivery. This one is fine.


So basically my question is:

Is there an easy way to analyze these tracepoint files ?
