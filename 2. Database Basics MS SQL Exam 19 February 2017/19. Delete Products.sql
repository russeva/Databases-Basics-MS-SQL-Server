
CREATE TRIGGER tr_DeleteRelationsOnProduct ON Products FOR DELETE
AS
	DELETE FROM ProductsIngredients
	WHERE ProductId = (SELECT Id FROM deleted);

	DELETE FROM Feedbacks
	WHERE ProductId = (SELECT ProductId FROM deleted);

	DELETE FROM Products
	WHERE Id = (SELECT Id FROM deleted);

	