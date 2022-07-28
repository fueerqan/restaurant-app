import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/widgets/description.dart' as descriptionWidget;

void main() {
  group("Description Widget", () {
    testWidgets(
      "Should not show view more if description less than 100 chars",
      (WidgetTester tester) async {
        String description = "This is short";

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: descriptionWidget.Description(description: description),
            ),
          ),
        );

        /// expect the description title only one
        expect(find.text("Description"), findsOneWidget);

        /// expect the description content showing all
        expect(find.text(description), findsOneWidget);

        /// expect the view more not showing
        expect(find.text("View More"), findsNothing);

        /// expect the view less also not showing
        expect(find.text("View Less"), findsNothing);
      },
    );

    testWidgets(
      "Should show view more / view less if description more than or equals to 100 chars",
      (WidgetTester tester) async {
        String description =
            "This is a long description, This is a long description, This is a long description, This is a long description, This is a long description, This is a long description, This is a long description, This is a long description, This is a long description, ";

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: descriptionWidget.Description(description: description),
            ),
          ),
        );

        Text descriptionContent =
            find.text(description).evaluate().first.widget as Text;
        final viewMore = find.ancestor(
          of: find.text("View More"),
          matching: find.byType(GestureDetector),
        );

        /// expect the description title only one
        expect(find.text("Description"), findsOneWidget);

        /// expect the description content showing all
        expect(find.text(description), findsOneWidget);

        /// expect the view more show
        expect(find.text("View More"), findsOneWidget);

        /// expect the view less not showing
        expect(find.text("View Less"), findsNothing);

        /// expect description max line 4
        expect(descriptionContent.maxLines, 4);

        /// tap view more to change the description state
        await tester.tap(viewMore.first);
        await tester.pumpAndSettle();

        descriptionContent =
            find.text(description).evaluate().first.widget as Text;

        /// expect the view more not showing
        expect(find.text("View More"), findsNothing);

        /// expect the view less show
        expect(find.text("View Less"), findsOneWidget);

        /// expect description max line 50
        expect(descriptionContent.maxLines, 50);
      },
    );
  });
}
