From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: Re: Enabling and disabling events
Date: Wed, 11 Sep 2013 12:22:13 +0000
Message-ID: <009B25148989C6458484484699278506E5388F53__19017.1050759547$1378902212$gmane$org@EU-MBX-01.mgc.mentorg.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD2678D70B@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<009B25148989C6458484484699278506E5388E0E@EU-MBX-01.mgc.mentorg.com>
	<48CF5AC71E61DB46B70D0F388054EFFD2678DB8E@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VJjR9-0007cJ-Ci
	for lttng-dev@lists.lttng.org; Wed, 11 Sep 2013 08:22:29 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD2678DB8E@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Daniel,

I can see your point about how the events are created. I do not completely agree with your views, but it is not essential that I do.

How about the following (this is based on the ideas you have brought forth):

We keep the enable-event command as it is. However, we enhance the event name specification syntax somewhat. We could of course do a full regex matching, but I fear that would get too slow.  Instead we'd have something like

$ lttng enable-event -u "*!mine*!alsomine"

This would enable any event ('*'), except those who match with mine* or alsomine.

The matching logic would separate the name specification into parts, using the ! character as a separator. If the new event name matches the first part but does not match any of the latter parts, then the event gets enabled.

I don't like collating the event enablers into unified specifications. I'd like to have each enable-event command create its own entries into the enabler list. I feel a bit uneasy if the event enabler code gets too sophisticated.

I'm still unsure how the disable-event command should work. I'm playing around with the idea that the event specification in the disable-event command should exactly match the event specification given in the enable-event command. It does not feel good, but any solution around it seems to bring about the ideas about disable-lists which I would like to avoid.

Cheers,
JP Ikaheimonen | SW Development Engineer http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Nucleus(r) | Linux(r) | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other countries.
