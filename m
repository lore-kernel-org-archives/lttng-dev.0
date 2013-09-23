From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [LTTng UST] [RFC] Event exclusion feature
Date: Mon, 23 Sep 2013 08:01:17 +0000
Message-ID: <009B25148989C6458484484699278506E5389EBC__34862.0651093826$1379923337$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VO15C-0007fV-Mx
	for lttng-dev@lists.lttng.org; Mon, 23 Sep 2013 04:01:29 -0400
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VO156-0001sM-Kz from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Mon, 23 Sep 2013 01:01:20 -0700
Content-Language: en-US
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

After some discussion on and off this mailing list, I present the interface to the event exclusion feature.

Use case:
We are providing libraries for an application developer. The libraries contain LTTng UST tracepoints, and we use them to get information about how the application uses the library.
The application developer also uses LTTng UST tracepoints, for their own use, over which we have no control. We also do not know the names of their tracepoints.
We want to use LTTng to separate the events to two different channels. One would contain all our library events, whereas the other would contain all other events.

Currently there is no way in LTTng to trace 'all events except these ones whose names I know'.
I suggest the following:

1) Enhance enable-event command for UST tracepoint events. Add an --exclude parameter to specify exclusions to enabling wildcards.

$ lttng enable-event -u -c mychan 'myapp*' --exclude myapp_comp1  
UST event myapp* excluding myapp_comp1* created in channel mychan

This command enabled all events starting with myapp, except those starting with myapp_comp1.

2) You can specify multiple exclusions. The following is valid:

$ lttng enable-event 'myapp*' --exclude 'myapp_comp1*, myapp_comp2*'
 UST event myapp* excluding myapp_comp1*, myapp_comp2* created in channel mychan

3) The -exclude option applies to all given events in the command. That is, the command 

$ lttng enable-event 'myap*,m*' --exclude 'myapp_comp1*'

would be equivalent to

$ lttng enable-event 'myap*' --exclude 'myapp_comp1*'
 $ lttng enable-event 'm*' --exclude 'myapp_comp1*'

4) When using --exclude, the event name should be a wildcard specification, and the excluded events should be a proper subset of the event specification. Otherwise, a warning is given, and the excluder is discarded. If the excluder fully covers the given event so that no events would be enabled, an error is given.

$ lttng enable-event 'myap2*' --exclude 'myapp_comp1*'
Warning: Event myap2*: myapp_comp1* does not exclude any events from myap2* 
UST event myap2* created in channel mychan

$ lttng enable-event 'myap2*' --exclude 'my*'
Error: Event myap2*: my* excludes all events from myap2*.

5) When disabling an event that has been enabled with exclusions, the exclusions do not need to be specified again. 

$ lttng enable-event -u -c mychan 'myapp2*' --exclude 'myapp2_comp1*' 
UST event myapp2* excluding myapp2_comp1* created in channel mychan 
$ lttng disable-event -u -c mychan 'myapp2*' 
UST event myapp2* disabled in channel mychan


JP Ikaheimonen | SW Development Engineer http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Nucleus(r) | Linux(r) | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other countries.
