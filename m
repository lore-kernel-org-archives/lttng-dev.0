From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Improving the enable-event and disable-event commands
Date: Tue, 27 Oct 2015 18:59:56 -0400
Message-ID: <CAB4xu_2n8fBTZE5oZk7drxEg3-76EwPWtj4oDMpRYY2=+_1zXw__21531.3276429244$1445986884$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1ZrDEF-0001CM-F0
 for lttng-dev@lists.lttng.org; Tue, 27 Oct 2015 19:00:33 -0400
Received: by lffz202 with SMTP id z202so180105617lff.3
 for <lttng-dev@lists.lttng.org>; Tue, 27 Oct 2015 16:00:25 -0700 (PDT)
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

Hello LTTngers!

This is a request for comments regarding the suggested solutions to
two fundamental problems with the `enable-event`/`disable-event` CLI
command (and their associated API functions).

Both problems and their proposed solution are independent, and it is
recommended that problem 1 be solved before problem 2, as its proposed
solution is easier to implement.

The solutions suggested below are designed to maintain full backward
compatibility with LTTng 2.7 while still improving the `enable-event`
and `disable-event` commands.

Feel free to contribute your own ideas!

Philippe Proulx


Context
=======

LTTng came to this world with the concept of switching the tracing
activity of possible system events on and off from the command-line,
hence the _enable_ and _disable_ names.

Eventually, wildcards in event names and other event activation
criteria were added (dynamic filters, log levels). All those features
were added as new options to the `enable-event` command. In this case,
however, we're not simply switching existing events on, but rather
_creating_ new **tuples** of conditions to be met for an event, existing
or not, to be emitted by the LTTng tracers. Those tuples, as of
LTTng 2.7, have the following components:

  * **Domain**: `--kernel`, `--userspace`, `--jul`, `--log4j`, and
    `--python` options
  * **Event name** (may contain a wildcard at the end, in which case a list
    of specific event names to exclude (`--exclude` option) may also exist):
    1st positional argument
  * **Event log level(s)**: `--loglevel` and `--loglevel-only` options
    (default: any log level)
  * **Filter string**: `--filter` option (default: `1`, which is always true)

For example, the command

    lttng enable-event -u hello:world --loglevel TRACE_INFO

creates and enables this tuple:

  * Domain:             user space
  * Event name:         match `hello:world`
  * Event log level(s): <= `TRACE_INFO`
  * Filter string:      `1`

As long as this tuple is enabled, any user space event matching those
conditions will be emitted by the tracer, even if there was no such
matching event when the `enable-event` command was executed.


Problem 1: `enable-event` cannot enable more than one event tuple at a time
===========================================================================

An issue is encountered when using the `--all` option of the
`enable-event` command. The `--all` option, as it is implemented
today, is the equivalent of providing the event name `*`.

For example:

    lttng enable-event -u --all
    lttng enable-event -u something --filter 'id >= 10'
    lttng enable-event -u 'els*' --exclude else,elsy

creates and enables those tuples:

  * Tuple 1:
    * Domain:             user space
    * Event name:         match anything
    * Event log level(s): any
    * Filter string:      `1`
  * Tuple 2:
    * Domain:             user space
    * Event name:         match `something`
    * Event log level(s): any
    * Filter string:      `id >= 10`
  * Tuple 3:
    * Domain:             user space
    * Event name:         match `els` followed by anything,
                          except `else` and `elsy`
    * Event log level(s): any
    * Filter string:      `1`

Now, let's disable all those tuples:

    lttng disable-event -u -a

All three tuples are disabled. What if we need to enable all three
tuples? Using `--all` seems intuitive:

    lttng enable-event -u --all

But, as mentioned above, this is the equivalent of:

    lttng enable-event -u '*'

and so, only tuple 1 is enabled, leaving the other two
disabled. In other words, it is not possible, today, to enable more than
one event tuple matching specific conditions.

More generally, this problem can be exhibited when event names with
wildcards are used.


Proposed solution
-----------------

Ideally, the `enable-event` command should be split in two individual
commands: `create-event` for creating new tuples and `enable-event` for
enabling existing _tuples_ matching specific conditions.

Unfortunately, the `enable-event` command already fullfills both
roles, and its current behaviour cannot be changed with a minor
release.

It was suggested that a `--match` option be added to the `enable-event`
command. The presence of the `--match` option affects the command's
behaviour as such:

  * Absent: **legacy mode**. The `enable-event` command behaves as it
    does today. Enabling a nonexistent tuple creates it. There is no way
    to enable more than one tuple at a time in this mode.
  * Present: **match mode**. Enabling a nonexistent tuple has no effect
    (this version of the command does not create tuples). Any unspecified
    tuple criterion is considered a _match all_ (don't care). This mode
    can enable more than one tuple at a time.

For example, it is now possible to enable all the _existing tuples_
having a log level equal to `TRACE_WARNING`:

    lttng enable-event --match -u --loglevel-only TRACE_WARNING

Or all the _existing_ tuples having an event name starting with `hello`:

    lttng enable-event --match -u hello'*'

The same command without `--match`:

    lttng enable-event -u hello'*'

would create a new tuple with the event name `hello*`.

When the desired action is to enable all tuples with a specific event name
containing a wildcard, the latter must be escaped with `\`:

    lttng enable-event -u test
    lttng enable-event -u test23
    lttng enable-event -u test'*'
    lttng enable-event -u test'*' --loglevel TRACE_INFO
    lttng enable-event -u test'*' --filter 'yeah != 23'

Here,

    lttng enable-event --match -u test'*'

enables all the events above, whereas

    lttng enable-event --match -u test'\*'

enables the last three because their name contains the actual
wildcard character.

Even though the event type is not part of the tuple conditions,
since two events with different types cannot share the same name,
the `enable-event` command in match mode still offers the event
type options to match existing events. For example,

    lttng enable-event --match -k --function

matches all existing kernel event tuples having the dynamic function
probe type.

The domain option is not mandatory in match mode: it's a criterion
to match. So this:

    lttng enable-event --match eye

enables all the event tuples which belong to all the possible tracing
domains and have the name `eye`.

A `--match` option is also added to the `disable-event` command.
This option behaves like its equivalent on the `enable-event` command:
it allows to disable multiple event tuples at the same time.

It has to be noted that the current behaviour of `disable-event -a`
implies a match mode: it targets all the enabled event tuples, not
the `*` event like `enable-event -a` does. In other words, `--match`
has no effect on `disable-event -a`, but it does on `enable-event -a`.
This asymmetry must remain to ensure full backward compatibility.


Problem 2: enabling an existing event tuple requires all its conditions
=======================================================================

Let us create two event tuples:

    lttng enable-event -u hello:world --loglevel TRACE_INFO
    lttng enable-event -u hello:world

which creates and enables the following tuples:

  * Tuple 1:
    * Domain:             user space
    * Event name:         match `hello:world`
    * Event log level(s): <= `TRACE_INFO`
    * Filter string:      `1`
  * Tuple 2:
    * Domain:             user space
    * Event name:         match `hello:world`
    * Event log level(s): any
    * Filter string:      `1`

Now, we have two enabled tuples sharing the same event name: their
only difference is their log level condition.

The `disable-event` command matches existing event names; this command
cannot, as for LTTng 2.7, match other conditions. In this case, our
only way to disable the first tuple, but leave the second one enabled,
is disabling both first:

    lttng disable-event -u hello:world

and then enabling the first one again:

    lttng enable-event -u hello:world --loglevel TRACE_INFO

A mechanism to uniquely identify both tuples would be interesting, since
right now, all the conditions must be repeated on the command-line to
target a specific tuple.


Proposed solution
-----------------

The problem of uniquely identifying event tuples can be solved by
assigning a unique _rule name_ (or _alias name_) to each tuple.

When creating a tuple, a rule name is automatically assigned to it
using the event name (which is a mandatory criterion). Since many
event tuples may coexist with the same event names, a numeric suffix
is appended to the rule name. For example:

    lttng enable-event -u hello
    lttng enable-event -u hello --loglevel TRACE_INFO
    lttng enable-event -u hello --filter 'a < 23'
    lttng enable-event -u hello'*'
    lttng enable-event -u hello.all

creates five rules named:

  * `hello`
  * `hello.2`
  * `hello.3`
  * `hello.all`
  * `hello.all.2`

A rule name can be assigned manually to a tuple when creating it
using the new `--rule` option of the `enable-event` command:

    lttng enable-event -u --rule hi           hello
    lttng enable-event -u --rule meow         hello --loglevel TRACE_INFO
    lttng enable-event -u --rule hi-with-filt hello --filter 'a < 23'
    lttng enable-event -k --rule fn:get-opt   get_opt --function get_option

Rule names are unique within the tracing session.

The `list` command shows the rule names assigned to each event tuple,
be it automatically or manually. The `disable-event` and `enable-event`
commands can target existing rule names using the `--rule` option:

    lttng disable-event --rule hi-with-filt
    lttng disable-event --rule meow
    lttng enable-event  --rule hi-with-filt

Another example; all system calls can be grouped under the same
rule name:

    lttng enable-event -k --syscall --all --rule syscalls

Wildcards can be used when enabling/disabling rules. With carefully
crafted rule names, a hierarchy can be created and parent rules can
be enabled/disabled at once. For example, consider the following rule
names:

    User space:
      apache:config
      apache:http
      apache:https
      apache:log
      maria:error
      maria:query
      maria:server

    Kernel:
      sys:driver:input
      sys:driver:leds
      sys:driver:sound
      sys:io
      sys:net:recv
      sys:net:send
      sys:power
      sys:sched

All driver event tuples can be disabled at once:

    lttng disable-event --rule sys:driver:'*'

MariaDB tuples can be turned on and off in one command:

    lttng disable-event --rule maria:'*'
    lttng enable-event  --rule maria:'*'

It is possible to use the `enable-event` command in match mode (as
described in the previous solution). The command

    lttng enable-event --match --rule apache:'*' --loglevel-only TRACE_INFO

only enables the existing Apache HTTP Server event tuples having a log
level set to `TRACE_INFO`.
