From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: Re: Enabling and disabling events
Date: Tue, 10 Sep 2013 11:40:51 +0000
Message-ID: <009B25148989C6458484484699278506E5388E0E__47189.059717539$1378813303$gmane$org@EU-MBX-01.mgc.mentorg.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD2678D70B@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VJMJY-0005zL-6l
	for lttng-dev@lists.lttng.org; Tue, 10 Sep 2013 07:41:00 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD2678D70B@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca)" <Daniel.Thibault@drdc-rddc.gc.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Daniel,
as you can see, things easily get too complicated.

Currently in LTTng you can only disable events that are enabled in the first place. In other words, an event is born disabled, as if 'lttng disable-event "*"' had been issued whenever a channel is created. We already have a mechanism to un-disable events - this is the enable-event command. I do not see any reason to add another command to do exactly what enable-event already does. If we want to 'disable all events except 'a'' we can call lttng enable-event 'a'. Symmetrically, I would like to have 'enable all events except 'a'', but currently this is impossible.

I still propose keeping the disable-event and enable-event commands asymmetrical. Based on your thoughts below, I also suggest keeping two lists for the enabled events: one for the enablements, and one for the exceptions to the enablements. The items in the latter list would point to specific items in the former list, so that the exceptions would be tied to certain enablements.

So for instance,

$ lttng enable-event -u 'x'
$ lttng list session
Events:
  x [enabled]
$ lttng enable-event -u "x*" --except "xa*"
$ lttng list session
Events:
  x [enabled]
  x* [enabled, exception xa*]
$ lttng enable-event -u "x*" --except "xb*"
$ lttng list session
  x [enabled]
  x* [enabled, exception xa*]
  x* [enabled, exception xb*]

Again, all the enablements would be checked, and the event would be enabled if any of the enablements match.

If an event enablement has an exception, it must be used in the disable-event command also:
$ lttng disable-event -u "x*" --except "xb*"
$ lttng list session
  x [enabled]
  x* [enabled, exception xa*]
  x* [disabled, exception xb*]

Comments are very welcome.

JP Ikaheimonen | SW Development Engineer http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Nucleus(r) | Linux(r) | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other countries.
